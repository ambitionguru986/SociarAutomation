import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_state.freezed.dart';

@freezed
sealed class AttendanceState with _$AttendanceState {
  const factory AttendanceState.initial({
    @Default([]) List<String> logs,
    String? savedToken,
    DateTime? startDate,
    DateTime? endDate,
    @Default(true) bool saveTokenLocally,
    @Default(false) bool isSingleDateMode,
    @Default(true) bool skipWeekends,
    @Default(true) bool submitAttendance,
    @Default(false) bool submitWorklog,
  }) = AttendanceInitial;

  const factory AttendanceState.running({
    required List<String> logs,
    String? savedToken,
    DateTime? startDate,
    DateTime? endDate,
    @Default(true) bool saveTokenLocally,
    @Default(false) bool isSingleDateMode,
    @Default(true) bool skipWeekends,
    @Default(true) bool submitAttendance,
    @Default(false) bool submitWorklog,
  }) = AttendanceRunning;

  const factory AttendanceState.completed({
    required List<String> logs,
    String? savedToken,
    DateTime? startDate,
    DateTime? endDate,
    @Default(true) bool saveTokenLocally,
    @Default(false) bool isSingleDateMode,
    @Default(true) bool skipWeekends,
    @Default(true) bool submitAttendance,
    @Default(false) bool submitWorklog,
  }) = AttendanceCompleted;

  const factory AttendanceState.error({
    required String message,
    required List<String> logs,
    String? savedToken,
    DateTime? startDate,
    DateTime? endDate,
    @Default(true) bool saveTokenLocally,
    @Default(false) bool isSingleDateMode,
    @Default(true) bool skipWeekends,
    @Default(true) bool submitAttendance,
    @Default(false) bool submitWorklog,
  }) = AttendanceError;
}
