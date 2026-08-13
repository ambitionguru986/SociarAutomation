import 'package:equatable/equatable.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

class LoadTokenEvent extends AttendanceEvent {}

class UpdateFormStateEvent extends AttendanceEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? saveTokenLocally;
  final bool? isSingleDateMode;
  final bool? skipWeekends;
  final bool? submitAttendance;
  final bool? submitWorklog;

  const UpdateFormStateEvent({
    this.startDate,
    this.endDate,
    this.saveTokenLocally,
    this.isSingleDateMode,
    this.skipWeekends,
    this.submitAttendance,
    this.submitWorklog,
  });

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        saveTokenLocally,
        isSingleDateMode,
        skipWeekends,
        submitAttendance,
        submitWorklog,
      ];
}

class ExecuteAttendanceEvent extends AttendanceEvent {
  final String token;
  final String worklogText;
  final String reason;

  const ExecuteAttendanceEvent({
    required this.token,
    this.worklogText = "",
    this.reason = "",
  });

  @override
  List<Object> get props => [token, worklogText, reason];
}

class ApproveAttendanceRequestsEvent extends AttendanceEvent {
  final String token;
  final bool saveTokenLocally;

  const ApproveAttendanceRequestsEvent({
    required this.token,
    this.saveTokenLocally = true,
  });

  @override
  List<Object> get props => [token, saveTokenLocally];
}
