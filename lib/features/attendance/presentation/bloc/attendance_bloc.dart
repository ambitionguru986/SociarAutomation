import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/worklog_entry.dart';
import '../../domain/usecases/approve_attendance_request.dart';
import '../../domain/usecases/fetch_pending_request_ids.dart';
import '../../domain/usecases/get_token.dart';
import '../../domain/usecases/save_token.dart';
import '../../domain/usecases/submit_attendance.dart';
import '../../domain/usecases/submit_worklog.dart';
import '../../../../core/usecases/usecase.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

// I2: Static regex — compiled once, reused on every parse call
final _timeRangeRegex = RegExp(
  r'\[(\d{1,2}:\d{2})\s*-\s*(\d{1,2}:\d{2})\]\s*(.*)',
);
final _datePattern = RegExp(r'\b\d{4}-\d{2}-\d{2}\b');

@injectable
class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final GetToken getToken;
  final SaveToken saveToken;
  final SubmitAttendance submitAttendance;
  final SubmitWorklog submitWorklog;
  final FetchPendingRequestIds fetchPendingRequestIds;
  final ApproveAttendanceRequest approveAttendanceRequest;

  AttendanceBloc({
    required this.getToken,
    required this.saveToken,
    required this.submitAttendance,
    required this.submitWorklog,
    required this.fetchPendingRequestIds,
    required this.approveAttendanceRequest,
  }) : super(const AttendanceInitial()) {
    on<LoadTokenEvent>(_onLoadToken);
    on<ExecuteAttendanceEvent>(_onExecuteAttendance);
    on<ApproveAttendanceRequestsEvent>(_onApproveAttendanceRequests);
  }

  Future<void> _onLoadToken(
    LoadTokenEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    final result = await getToken(const NoParams());
    result.fold(
      (failure) => emit(const AttendanceInitial()),
      (token) => emit(AttendanceInitial(savedToken: token)),
    );
  }

  Future<void> _onExecuteAttendance(
    ExecuteAttendanceEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    if (event.saveTokenLocally) {
      await saveToken(event.token);
    }
    final previousToken = event.saveTokenLocally ? event.token : null;

    final currentLogs = <String>['🚀 Starting execution...'];
    emit(AttendanceRunning(logs: List.from(currentLogs), savedToken: previousToken));

    DateTime current = event.startDate;
    final DateTime end = event.endDate;

    while (!current.isAfter(end)) {
      // Skip Fridays (5) and Saturdays (6) when enabled
      if (event.skipWeekends &&
          (current.weekday == DateTime.friday ||
              current.weekday == DateTime.saturday)) {
        currentLogs.add('⏭️ [${_formatDate(current)}] Skipped (Weekend)');
        emit(AttendanceRunning(
          logs: List.from(currentLogs),
          savedToken: previousToken,
        ));
        current = current.add(const Duration(days: 1));
        continue;
      }

      final String dateStr = _formatDate(current);

      if (event.submitAttendance) {
        currentLogs.add('⏳ [$dateStr] Processing Attendance...');
        emit(AttendanceRunning(
          logs: List.from(currentLogs),
          savedToken: previousToken,
        ));

        final result = await submitAttendance(
          ApiParams(date: dateStr, token: event.token, reason: event.reason),
        );

        result.fold(
          (failure) => currentLogs.add('❌ [$dateStr] Attendance Failed: ${failure.message}'),
          (_) => currentLogs.add('✅ [$dateStr] Attendance Successful'),
        );

        emit(AttendanceRunning(
          logs: List.from(currentLogs),
          savedToken: previousToken,
        ));
        await Future<void>.delayed(const Duration(milliseconds: 600));
      }

      if (event.submitWorklog) {
        final textForDate = _getTextForDate(event.worklogText, dateStr);

        if (textForDate == null) {
          currentLogs.add(
            '⏭️ [$dateStr] Skipped Worklog (No data provided for this date)',
          );
          emit(AttendanceRunning(
            logs: List.from(currentLogs),
            savedToken: previousToken,
          ));
        } else {
          currentLogs.add('⏳ [$dateStr] Processing Worklog...');
          emit(AttendanceRunning(
            logs: List.from(currentLogs),
            savedToken: previousToken,
          ));

          final entries = _parseEntries(textForDate);

          if (entries.isEmpty) {
            currentLogs.add(
              '⚠️ [$dateStr] No valid worklog formatting '
              '([HH:MM - HH:MM]) found. Falling back to default split.',
            );
          }

          final finalEntries =
              entries.isNotEmpty ? entries : _getDefaultEntries(textForDate);

          final worklogResult = await submitWorklog(WorklogParams(
            date: dateStr,
            token: event.token,
            entries: finalEntries,
          ));

          worklogResult.fold(
            (failure) =>
                currentLogs.add('❌ [$dateStr] Worklog Failed: ${failure.message}'),
            (_) {
              currentLogs.add('✅ [$dateStr] Worklog Successful');
              for (final entry in finalEntries) {
                currentLogs.add(
                  '   ┕ [${entry.startTime} - ${entry.endTime}] ${entry.description}',
                );
              }
            },
          );

          emit(AttendanceRunning(
            logs: List.from(currentLogs),
            savedToken: previousToken,
          ));
          await Future<void>.delayed(const Duration(milliseconds: 600));
        }
      }

      current = current.add(const Duration(days: 1));
    }

    currentLogs.add('🏁 Execution completed.');
    emit(AttendanceCompleted(
      logs: List.from(currentLogs),
      savedToken: previousToken,
    ));
  }

  Future<void> _onApproveAttendanceRequests(
    ApproveAttendanceRequestsEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    if (event.saveTokenLocally) {
      await saveToken(event.token);
    }
    final previousToken = event.saveTokenLocally ? event.token : null;

    final currentLogs = <String>['🚀 Fetching pending attendance requests...'];
    emit(AttendanceRunning(
      logs: List.from(currentLogs),
      savedToken: previousToken,
    ));

    final fetchResult =
        await fetchPendingRequestIds(TokenParams(token: event.token));

    await fetchResult.fold(
      (failure) async {
        currentLogs.add('❌ Failed to fetch requests: ${failure.message}');
        emit(AttendanceCompleted(
          logs: List.from(currentLogs),
          savedToken: previousToken,
        ));
      },
      (ids) async {
        if (ids.isEmpty) {
          currentLogs.add('✅ No pending requests found.');
          emit(AttendanceCompleted(
            logs: List.from(currentLogs),
            savedToken: previousToken,
          ));
          return;
        }

        currentLogs.add('📋 Found ${ids.length} pending request(s). Approving...');
        emit(AttendanceRunning(
          logs: List.from(currentLogs),
          savedToken: previousToken,
        ));

        for (final id in ids) {
          currentLogs.add('⏳ Approving request #$id...');
          emit(AttendanceRunning(
            logs: List.from(currentLogs),
            savedToken: previousToken,
          ));

          final result = await approveAttendanceRequest(
            ApproveParams(id: id, token: event.token),
          );

          result.fold(
            (failure) =>
                currentLogs.add('❌ Request #$id Failed: ${failure.message}'),
            (_) => currentLogs.add('✅ Request #$id Approved'),
          );

          emit(AttendanceRunning(
            logs: List.from(currentLogs),
            savedToken: previousToken,
          ));
          await Future<void>.delayed(const Duration(milliseconds: 600));
        }

        currentLogs.add('🏁 All requests processed.');
        emit(AttendanceCompleted(
          logs: List.from(currentLogs),
          savedToken: previousToken,
        ));
      },
    );
  }

  // I2: Uses static regex field to avoid recompilation on each call
  List<WorklogEntry> _parseEntries(String text) {
    final List<WorklogEntry> entries = [];
    for (final line in text.split('\n')) {
      final match = _timeRangeRegex.firstMatch(line.trim());
      if (match != null) {
        String start = match.group(1)!;
        String end = match.group(2)!;
        if (start.length == 4) start = '0$start';
        if (end.length == 4) end = '0$end';
        entries.add(WorklogEntry(
          startTime: start,
          endTime: end,
          description: match.group(3)!.trim(),
        ));
      }
    }
    return entries;
  }

  String? _getTextForDate(String text, String targetDate) {
    if (!_datePattern.hasMatch(text)) return text;

    final lines = text.split('\n');
    final buffer = StringBuffer();
    bool recording = false;
    bool foundDate = false;

    for (final line in lines) {
      final match = _datePattern.firstMatch(line);
      if (match != null) {
        recording = match.group(0) == targetDate;
        if (recording) foundDate = true;
      } else if (recording) {
        buffer.writeln(line);
      }
    }

    return foundDate ? buffer.toString() : null;
  }

  List<WorklogEntry> _getDefaultEntries(String text) {
    final cleanText = text.trim();
    if (cleanText.length > 100) {
      final midpoint = cleanText.length ~/ 2;
      return [
        WorklogEntry(
          startTime: '09:00',
          endTime: '13:00',
          description: cleanText.substring(0, midpoint),
        ),
        WorklogEntry(
          startTime: '14:00',
          endTime: '18:00',
          description: cleanText.substring(midpoint),
        ),
      ];
    }
    return [
      WorklogEntry(
        startTime: '09:00',
        endTime: '13:00',
        description: cleanText,
      ),
      const WorklogEntry(
        startTime: '14:00',
        endTime: '18:00',
        description: 'Continued work...',
      ),
    ];
  }

  String _formatDate(DateTime date) {
    return '${date.year}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }
}
