import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../domain/entities/worklog_entry.dart';
import '../../../../core/error/exceptions.dart';

const _kBaseUrl = 'https://new-central-api.sociair.com/api/hris';
const _kRequestTimeout = Duration(seconds: 30);

final _log = Logger();

abstract class AttendanceRemoteDataSource {
  Future<void> submitAttendance(String date, String token, String reason);
  Future<void> submitWorklog(
    String date,
    String token,
    List<WorklogEntry> entries,
  );
  Future<List<int>> fetchPendingRequestIds(String token);
  Future<void> approveAttendanceRequest(int id, String token);
}

@LazySingleton(as: AttendanceRemoteDataSource)
class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final http.Client client;

  AttendanceRemoteDataSourceImpl({required this.client});

  Map<String, String> _buildHeaders(String token) {
    return {
      'accept': 'application/json, text/plain, */*',
      'accept-encoding': 'gzip, deflate, br, zstd',
      'accept-language': 'en-US,en;q=0.9',
      'authorization': 'Bearer $token',
      'origin': 'https://eynoratech.sociair.io',
      'referer': 'https://eynoratech.sociair.io/',
      'user-agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) '
          'AppleWebKit/537.36 (KHTML, like Gecko) '
          'Chrome/151.0.0.0 Safari/537.36',
      'x-requested-with': 'XMLHttpRequest',
    };
  }

  @override
  Future<void> submitAttendance(
    String date,
    String token,
    String reason,
  ) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$_kBaseUrl/attendance-request'),
    );

    request.headers.addAll(_buildHeaders(token));

    request.fields['hris_shift_type_id'] = '1';
    request.fields['check_in'] = '09:00';
    request.fields['check_out'] = '19:00';
    request.fields['request_date'] = date;
    request.fields['request_type'] = 'missing_punch_out';
    if (reason.isNotEmpty) {
      request.fields['remarks'] = reason;
    }

    try {
      final streamedResponse =
          await client.send(request).timeout(_kRequestTimeout);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          'Failed to submit attendance: '
          '${response.statusCode} ${response.reasonPhrase}\n'
          '${response.body}',
        );
      }
    } on TimeoutException {
      throw ServerException('submitAttendance timed out after 30 s');
    } catch (e, st) {
      if (e is ServerException) rethrow;
      _log.e('submitAttendance error', error: e, stackTrace: st);
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> submitWorklog(
    String date,
    String token,
    List<WorklogEntry> entries,
  ) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$_kBaseUrl/worklog'),
    );

    request.headers.addAll(_buildHeaders(token));
    request.fields['date'] = date;

    for (int i = 0; i < entries.length; i++) {
      final entry = entries[i];
      final prefix = 'entries[$i]';

      request.fields['$prefix[start_time]'] = entry.startTime;
      request.fields['$prefix[end_time]'] = entry.endTime;
      request.fields['$prefix[description]'] = '<p>${entry.description}</p>';
      request.fields['$prefix[mst_project_id]'] = '41';
      request.fields['$prefix[mst_kpi_id]'] = '';
      request.fields['$prefix[activity_type]'] = '';
      request.fields['$prefix[mst_dynamic_form_id]'] = '';
      request.fields['$prefix[dynamicForm]'] = i == 0 ? '585' : '424';

      if (i > 0) {
        request.fields['$prefix[id]'] =
            (DateTime.now().millisecondsSinceEpoch + i).toString();
      }
    }

    try {
      final streamedResponse =
          await client.send(request).timeout(_kRequestTimeout);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          'Failed to submit worklog: '
          '${response.statusCode} ${response.reasonPhrase}\n'
          '${response.body}',
        );
      }
    } on TimeoutException {
      throw ServerException('submitWorklog timed out after 30 s');
    } catch (e, st) {
      if (e is ServerException) rethrow;
      _log.e('submitWorklog error', error: e, stackTrace: st);
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<int>> fetchPendingRequestIds(String token) async {
    final List<int> pendingIds = [];
    int currentPage = 1;
    int lastPage = 1;

    do {
      final uri = Uri.parse(
        '$_kBaseUrl/subordinate/attendance-request',
      ).replace(queryParameters: {
        'page': currentPage.toString(),
        'rowsPerPage': '25',
        'query': '',
        'filters': '{}',
        'descending': 'true',
        'sortBy': 'id',
        'view': 'table',
      });

      try {
        final response = await client
            .get(uri, headers: _buildHeaders(token))
            .timeout(_kRequestTimeout);

        if (response.statusCode != 200) {
          throw ServerException(
            'Failed to fetch attendance requests: '
            '${response.statusCode} ${response.reasonPhrase}',
          );
        }

        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final data = json['data'] as List<dynamic>;
        final meta = json['meta'] as Map<String, dynamic>;

        lastPage = meta['last_page'] as int;

        for (final item in data) {
          if ((item['status'] as int) == 0) {
            pendingIds.add(item['id'] as int);
          }
        }
      } on TimeoutException {
        throw ServerException('fetchPendingRequestIds timed out after 30 s');
      } catch (e, st) {
        if (e is ServerException) rethrow;
        _log.e('fetchPendingRequestIds error', error: e, stackTrace: st);
        throw ServerException(e.toString());
      }

      currentPage++;
    } while (currentPage <= lastPage);

    return pendingIds;
  }

  @override
  Future<void> approveAttendanceRequest(int id, String token) async {
    final uri = Uri.parse('$_kBaseUrl/attendance-request/$id/set-status');

    final headers = {
      ..._buildHeaders(token),
      'content-type': 'application/json',
    };

    try {
      final response = await client
          .post(
            uri,
            headers: headers,
            body: jsonEncode({
              'status': 'APPROVED',
              'remarks': '',
              'rejection_reason': null,
            }),
          )
          .timeout(_kRequestTimeout);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          'Failed to approve request #$id: '
          '${response.statusCode} ${response.reasonPhrase}\n'
          '${response.body}',
        );
      }
    } on TimeoutException {
      throw ServerException('approveAttendanceRequest #$id timed out after 30 s');
    } catch (e, st) {
      if (e is ServerException) rethrow;
      _log.e('approveAttendanceRequest error', error: e, stackTrace: st);
      throw ServerException(e.toString());
    }
  }
}
