// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttendanceState {

 List<String> get logs; String? get savedToken; DateTime? get startDate; DateTime? get endDate; bool get saveTokenLocally; bool get isSingleDateMode; bool get skipWeekends; bool get submitAttendance; bool get submitWorklog;
/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceStateCopyWith<AttendanceState> get copyWith => _$AttendanceStateCopyWithImpl<AttendanceState>(this as AttendanceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceState&&const DeepCollectionEquality().equals(other.logs, logs)&&(identical(other.savedToken, savedToken) || other.savedToken == savedToken)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.saveTokenLocally, saveTokenLocally) || other.saveTokenLocally == saveTokenLocally)&&(identical(other.isSingleDateMode, isSingleDateMode) || other.isSingleDateMode == isSingleDateMode)&&(identical(other.skipWeekends, skipWeekends) || other.skipWeekends == skipWeekends)&&(identical(other.submitAttendance, submitAttendance) || other.submitAttendance == submitAttendance)&&(identical(other.submitWorklog, submitWorklog) || other.submitWorklog == submitWorklog));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(logs),savedToken,startDate,endDate,saveTokenLocally,isSingleDateMode,skipWeekends,submitAttendance,submitWorklog);

@override
String toString() {
  return 'AttendanceState(logs: $logs, savedToken: $savedToken, startDate: $startDate, endDate: $endDate, saveTokenLocally: $saveTokenLocally, isSingleDateMode: $isSingleDateMode, skipWeekends: $skipWeekends, submitAttendance: $submitAttendance, submitWorklog: $submitWorklog)';
}


}

/// @nodoc
abstract mixin class $AttendanceStateCopyWith<$Res>  {
  factory $AttendanceStateCopyWith(AttendanceState value, $Res Function(AttendanceState) _then) = _$AttendanceStateCopyWithImpl;
@useResult
$Res call({
 List<String> logs, String? savedToken, DateTime? startDate, DateTime? endDate, bool saveTokenLocally, bool isSingleDateMode, bool skipWeekends, bool submitAttendance, bool submitWorklog
});




}
/// @nodoc
class _$AttendanceStateCopyWithImpl<$Res>
    implements $AttendanceStateCopyWith<$Res> {
  _$AttendanceStateCopyWithImpl(this._self, this._then);

  final AttendanceState _self;
  final $Res Function(AttendanceState) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? logs = null,Object? savedToken = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? saveTokenLocally = null,Object? isSingleDateMode = null,Object? skipWeekends = null,Object? submitAttendance = null,Object? submitWorklog = null,}) {
  return _then(_self.copyWith(
logs: null == logs ? _self.logs : logs // ignore: cast_nullable_to_non_nullable
as List<String>,savedToken: freezed == savedToken ? _self.savedToken : savedToken // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,saveTokenLocally: null == saveTokenLocally ? _self.saveTokenLocally : saveTokenLocally // ignore: cast_nullable_to_non_nullable
as bool,isSingleDateMode: null == isSingleDateMode ? _self.isSingleDateMode : isSingleDateMode // ignore: cast_nullable_to_non_nullable
as bool,skipWeekends: null == skipWeekends ? _self.skipWeekends : skipWeekends // ignore: cast_nullable_to_non_nullable
as bool,submitAttendance: null == submitAttendance ? _self.submitAttendance : submitAttendance // ignore: cast_nullable_to_non_nullable
as bool,submitWorklog: null == submitWorklog ? _self.submitWorklog : submitWorklog // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceState].
extension AttendanceStatePatterns on AttendanceState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AttendanceInitial value)?  initial,TResult Function( AttendanceRunning value)?  running,TResult Function( AttendanceCompleted value)?  completed,TResult Function( AttendanceError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AttendanceInitial() when initial != null:
return initial(_that);case AttendanceRunning() when running != null:
return running(_that);case AttendanceCompleted() when completed != null:
return completed(_that);case AttendanceError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AttendanceInitial value)  initial,required TResult Function( AttendanceRunning value)  running,required TResult Function( AttendanceCompleted value)  completed,required TResult Function( AttendanceError value)  error,}){
final _that = this;
switch (_that) {
case AttendanceInitial():
return initial(_that);case AttendanceRunning():
return running(_that);case AttendanceCompleted():
return completed(_that);case AttendanceError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AttendanceInitial value)?  initial,TResult? Function( AttendanceRunning value)?  running,TResult? Function( AttendanceCompleted value)?  completed,TResult? Function( AttendanceError value)?  error,}){
final _that = this;
switch (_that) {
case AttendanceInitial() when initial != null:
return initial(_that);case AttendanceRunning() when running != null:
return running(_that);case AttendanceCompleted() when completed != null:
return completed(_that);case AttendanceError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<String> logs,  String? savedToken,  DateTime? startDate,  DateTime? endDate,  bool saveTokenLocally,  bool isSingleDateMode,  bool skipWeekends,  bool submitAttendance,  bool submitWorklog)?  initial,TResult Function( List<String> logs,  String? savedToken,  DateTime? startDate,  DateTime? endDate,  bool saveTokenLocally,  bool isSingleDateMode,  bool skipWeekends,  bool submitAttendance,  bool submitWorklog)?  running,TResult Function( List<String> logs,  String? savedToken,  DateTime? startDate,  DateTime? endDate,  bool saveTokenLocally,  bool isSingleDateMode,  bool skipWeekends,  bool submitAttendance,  bool submitWorklog)?  completed,TResult Function( String message,  List<String> logs,  String? savedToken,  DateTime? startDate,  DateTime? endDate,  bool saveTokenLocally,  bool isSingleDateMode,  bool skipWeekends,  bool submitAttendance,  bool submitWorklog)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AttendanceInitial() when initial != null:
return initial(_that.logs,_that.savedToken,_that.startDate,_that.endDate,_that.saveTokenLocally,_that.isSingleDateMode,_that.skipWeekends,_that.submitAttendance,_that.submitWorklog);case AttendanceRunning() when running != null:
return running(_that.logs,_that.savedToken,_that.startDate,_that.endDate,_that.saveTokenLocally,_that.isSingleDateMode,_that.skipWeekends,_that.submitAttendance,_that.submitWorklog);case AttendanceCompleted() when completed != null:
return completed(_that.logs,_that.savedToken,_that.startDate,_that.endDate,_that.saveTokenLocally,_that.isSingleDateMode,_that.skipWeekends,_that.submitAttendance,_that.submitWorklog);case AttendanceError() when error != null:
return error(_that.message,_that.logs,_that.savedToken,_that.startDate,_that.endDate,_that.saveTokenLocally,_that.isSingleDateMode,_that.skipWeekends,_that.submitAttendance,_that.submitWorklog);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<String> logs,  String? savedToken,  DateTime? startDate,  DateTime? endDate,  bool saveTokenLocally,  bool isSingleDateMode,  bool skipWeekends,  bool submitAttendance,  bool submitWorklog)  initial,required TResult Function( List<String> logs,  String? savedToken,  DateTime? startDate,  DateTime? endDate,  bool saveTokenLocally,  bool isSingleDateMode,  bool skipWeekends,  bool submitAttendance,  bool submitWorklog)  running,required TResult Function( List<String> logs,  String? savedToken,  DateTime? startDate,  DateTime? endDate,  bool saveTokenLocally,  bool isSingleDateMode,  bool skipWeekends,  bool submitAttendance,  bool submitWorklog)  completed,required TResult Function( String message,  List<String> logs,  String? savedToken,  DateTime? startDate,  DateTime? endDate,  bool saveTokenLocally,  bool isSingleDateMode,  bool skipWeekends,  bool submitAttendance,  bool submitWorklog)  error,}) {final _that = this;
switch (_that) {
case AttendanceInitial():
return initial(_that.logs,_that.savedToken,_that.startDate,_that.endDate,_that.saveTokenLocally,_that.isSingleDateMode,_that.skipWeekends,_that.submitAttendance,_that.submitWorklog);case AttendanceRunning():
return running(_that.logs,_that.savedToken,_that.startDate,_that.endDate,_that.saveTokenLocally,_that.isSingleDateMode,_that.skipWeekends,_that.submitAttendance,_that.submitWorklog);case AttendanceCompleted():
return completed(_that.logs,_that.savedToken,_that.startDate,_that.endDate,_that.saveTokenLocally,_that.isSingleDateMode,_that.skipWeekends,_that.submitAttendance,_that.submitWorklog);case AttendanceError():
return error(_that.message,_that.logs,_that.savedToken,_that.startDate,_that.endDate,_that.saveTokenLocally,_that.isSingleDateMode,_that.skipWeekends,_that.submitAttendance,_that.submitWorklog);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<String> logs,  String? savedToken,  DateTime? startDate,  DateTime? endDate,  bool saveTokenLocally,  bool isSingleDateMode,  bool skipWeekends,  bool submitAttendance,  bool submitWorklog)?  initial,TResult? Function( List<String> logs,  String? savedToken,  DateTime? startDate,  DateTime? endDate,  bool saveTokenLocally,  bool isSingleDateMode,  bool skipWeekends,  bool submitAttendance,  bool submitWorklog)?  running,TResult? Function( List<String> logs,  String? savedToken,  DateTime? startDate,  DateTime? endDate,  bool saveTokenLocally,  bool isSingleDateMode,  bool skipWeekends,  bool submitAttendance,  bool submitWorklog)?  completed,TResult? Function( String message,  List<String> logs,  String? savedToken,  DateTime? startDate,  DateTime? endDate,  bool saveTokenLocally,  bool isSingleDateMode,  bool skipWeekends,  bool submitAttendance,  bool submitWorklog)?  error,}) {final _that = this;
switch (_that) {
case AttendanceInitial() when initial != null:
return initial(_that.logs,_that.savedToken,_that.startDate,_that.endDate,_that.saveTokenLocally,_that.isSingleDateMode,_that.skipWeekends,_that.submitAttendance,_that.submitWorklog);case AttendanceRunning() when running != null:
return running(_that.logs,_that.savedToken,_that.startDate,_that.endDate,_that.saveTokenLocally,_that.isSingleDateMode,_that.skipWeekends,_that.submitAttendance,_that.submitWorklog);case AttendanceCompleted() when completed != null:
return completed(_that.logs,_that.savedToken,_that.startDate,_that.endDate,_that.saveTokenLocally,_that.isSingleDateMode,_that.skipWeekends,_that.submitAttendance,_that.submitWorklog);case AttendanceError() when error != null:
return error(_that.message,_that.logs,_that.savedToken,_that.startDate,_that.endDate,_that.saveTokenLocally,_that.isSingleDateMode,_that.skipWeekends,_that.submitAttendance,_that.submitWorklog);case _:
  return null;

}
}

}

/// @nodoc


class AttendanceInitial implements AttendanceState {
  const AttendanceInitial({ List<String> logs = const [], this.savedToken, this.startDate, this.endDate, this.saveTokenLocally = true, this.isSingleDateMode = false, this.skipWeekends = true, this.submitAttendance = true, this.submitWorklog = false}): _logs = logs;
  

 final  List<String> _logs;
@override@JsonKey() List<String> get logs {
  if (_logs is EqualUnmodifiableListView) return _logs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_logs);
}

@override final  String? savedToken;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override@JsonKey() final  bool saveTokenLocally;
@override@JsonKey() final  bool isSingleDateMode;
@override@JsonKey() final  bool skipWeekends;
@override@JsonKey() final  bool submitAttendance;
@override@JsonKey() final  bool submitWorklog;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceInitialCopyWith<AttendanceInitial> get copyWith => _$AttendanceInitialCopyWithImpl<AttendanceInitial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceInitial&&const DeepCollectionEquality().equals(other._logs, _logs)&&(identical(other.savedToken, savedToken) || other.savedToken == savedToken)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.saveTokenLocally, saveTokenLocally) || other.saveTokenLocally == saveTokenLocally)&&(identical(other.isSingleDateMode, isSingleDateMode) || other.isSingleDateMode == isSingleDateMode)&&(identical(other.skipWeekends, skipWeekends) || other.skipWeekends == skipWeekends)&&(identical(other.submitAttendance, submitAttendance) || other.submitAttendance == submitAttendance)&&(identical(other.submitWorklog, submitWorklog) || other.submitWorklog == submitWorklog));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_logs),savedToken,startDate,endDate,saveTokenLocally,isSingleDateMode,skipWeekends,submitAttendance,submitWorklog);

@override
String toString() {
  return 'AttendanceState.initial(logs: $logs, savedToken: $savedToken, startDate: $startDate, endDate: $endDate, saveTokenLocally: $saveTokenLocally, isSingleDateMode: $isSingleDateMode, skipWeekends: $skipWeekends, submitAttendance: $submitAttendance, submitWorklog: $submitWorklog)';
}


}

/// @nodoc
abstract mixin class $AttendanceInitialCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory $AttendanceInitialCopyWith(AttendanceInitial value, $Res Function(AttendanceInitial) _then) = _$AttendanceInitialCopyWithImpl;
@override @useResult
$Res call({
 List<String> logs, String? savedToken, DateTime? startDate, DateTime? endDate, bool saveTokenLocally, bool isSingleDateMode, bool skipWeekends, bool submitAttendance, bool submitWorklog
});




}
/// @nodoc
class _$AttendanceInitialCopyWithImpl<$Res>
    implements $AttendanceInitialCopyWith<$Res> {
  _$AttendanceInitialCopyWithImpl(this._self, this._then);

  final AttendanceInitial _self;
  final $Res Function(AttendanceInitial) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? logs = null,Object? savedToken = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? saveTokenLocally = null,Object? isSingleDateMode = null,Object? skipWeekends = null,Object? submitAttendance = null,Object? submitWorklog = null,}) {
  return _then(AttendanceInitial(
logs: null == logs ? _self._logs : logs // ignore: cast_nullable_to_non_nullable
as List<String>,savedToken: freezed == savedToken ? _self.savedToken : savedToken // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,saveTokenLocally: null == saveTokenLocally ? _self.saveTokenLocally : saveTokenLocally // ignore: cast_nullable_to_non_nullable
as bool,isSingleDateMode: null == isSingleDateMode ? _self.isSingleDateMode : isSingleDateMode // ignore: cast_nullable_to_non_nullable
as bool,skipWeekends: null == skipWeekends ? _self.skipWeekends : skipWeekends // ignore: cast_nullable_to_non_nullable
as bool,submitAttendance: null == submitAttendance ? _self.submitAttendance : submitAttendance // ignore: cast_nullable_to_non_nullable
as bool,submitWorklog: null == submitWorklog ? _self.submitWorklog : submitWorklog // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class AttendanceRunning implements AttendanceState {
  const AttendanceRunning({required  List<String> logs, this.savedToken, this.startDate, this.endDate, this.saveTokenLocally = true, this.isSingleDateMode = false, this.skipWeekends = true, this.submitAttendance = true, this.submitWorklog = false}): _logs = logs;
  

 final  List<String> _logs;
@override List<String> get logs {
  if (_logs is EqualUnmodifiableListView) return _logs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_logs);
}

@override final  String? savedToken;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override@JsonKey() final  bool saveTokenLocally;
@override@JsonKey() final  bool isSingleDateMode;
@override@JsonKey() final  bool skipWeekends;
@override@JsonKey() final  bool submitAttendance;
@override@JsonKey() final  bool submitWorklog;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceRunningCopyWith<AttendanceRunning> get copyWith => _$AttendanceRunningCopyWithImpl<AttendanceRunning>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceRunning&&const DeepCollectionEquality().equals(other._logs, _logs)&&(identical(other.savedToken, savedToken) || other.savedToken == savedToken)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.saveTokenLocally, saveTokenLocally) || other.saveTokenLocally == saveTokenLocally)&&(identical(other.isSingleDateMode, isSingleDateMode) || other.isSingleDateMode == isSingleDateMode)&&(identical(other.skipWeekends, skipWeekends) || other.skipWeekends == skipWeekends)&&(identical(other.submitAttendance, submitAttendance) || other.submitAttendance == submitAttendance)&&(identical(other.submitWorklog, submitWorklog) || other.submitWorklog == submitWorklog));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_logs),savedToken,startDate,endDate,saveTokenLocally,isSingleDateMode,skipWeekends,submitAttendance,submitWorklog);

@override
String toString() {
  return 'AttendanceState.running(logs: $logs, savedToken: $savedToken, startDate: $startDate, endDate: $endDate, saveTokenLocally: $saveTokenLocally, isSingleDateMode: $isSingleDateMode, skipWeekends: $skipWeekends, submitAttendance: $submitAttendance, submitWorklog: $submitWorklog)';
}


}

/// @nodoc
abstract mixin class $AttendanceRunningCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory $AttendanceRunningCopyWith(AttendanceRunning value, $Res Function(AttendanceRunning) _then) = _$AttendanceRunningCopyWithImpl;
@override @useResult
$Res call({
 List<String> logs, String? savedToken, DateTime? startDate, DateTime? endDate, bool saveTokenLocally, bool isSingleDateMode, bool skipWeekends, bool submitAttendance, bool submitWorklog
});




}
/// @nodoc
class _$AttendanceRunningCopyWithImpl<$Res>
    implements $AttendanceRunningCopyWith<$Res> {
  _$AttendanceRunningCopyWithImpl(this._self, this._then);

  final AttendanceRunning _self;
  final $Res Function(AttendanceRunning) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? logs = null,Object? savedToken = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? saveTokenLocally = null,Object? isSingleDateMode = null,Object? skipWeekends = null,Object? submitAttendance = null,Object? submitWorklog = null,}) {
  return _then(AttendanceRunning(
logs: null == logs ? _self._logs : logs // ignore: cast_nullable_to_non_nullable
as List<String>,savedToken: freezed == savedToken ? _self.savedToken : savedToken // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,saveTokenLocally: null == saveTokenLocally ? _self.saveTokenLocally : saveTokenLocally // ignore: cast_nullable_to_non_nullable
as bool,isSingleDateMode: null == isSingleDateMode ? _self.isSingleDateMode : isSingleDateMode // ignore: cast_nullable_to_non_nullable
as bool,skipWeekends: null == skipWeekends ? _self.skipWeekends : skipWeekends // ignore: cast_nullable_to_non_nullable
as bool,submitAttendance: null == submitAttendance ? _self.submitAttendance : submitAttendance // ignore: cast_nullable_to_non_nullable
as bool,submitWorklog: null == submitWorklog ? _self.submitWorklog : submitWorklog // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class AttendanceCompleted implements AttendanceState {
  const AttendanceCompleted({required  List<String> logs, this.savedToken, this.startDate, this.endDate, this.saveTokenLocally = true, this.isSingleDateMode = false, this.skipWeekends = true, this.submitAttendance = true, this.submitWorklog = false}): _logs = logs;
  

 final  List<String> _logs;
@override List<String> get logs {
  if (_logs is EqualUnmodifiableListView) return _logs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_logs);
}

@override final  String? savedToken;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override@JsonKey() final  bool saveTokenLocally;
@override@JsonKey() final  bool isSingleDateMode;
@override@JsonKey() final  bool skipWeekends;
@override@JsonKey() final  bool submitAttendance;
@override@JsonKey() final  bool submitWorklog;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceCompletedCopyWith<AttendanceCompleted> get copyWith => _$AttendanceCompletedCopyWithImpl<AttendanceCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceCompleted&&const DeepCollectionEquality().equals(other._logs, _logs)&&(identical(other.savedToken, savedToken) || other.savedToken == savedToken)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.saveTokenLocally, saveTokenLocally) || other.saveTokenLocally == saveTokenLocally)&&(identical(other.isSingleDateMode, isSingleDateMode) || other.isSingleDateMode == isSingleDateMode)&&(identical(other.skipWeekends, skipWeekends) || other.skipWeekends == skipWeekends)&&(identical(other.submitAttendance, submitAttendance) || other.submitAttendance == submitAttendance)&&(identical(other.submitWorklog, submitWorklog) || other.submitWorklog == submitWorklog));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_logs),savedToken,startDate,endDate,saveTokenLocally,isSingleDateMode,skipWeekends,submitAttendance,submitWorklog);

@override
String toString() {
  return 'AttendanceState.completed(logs: $logs, savedToken: $savedToken, startDate: $startDate, endDate: $endDate, saveTokenLocally: $saveTokenLocally, isSingleDateMode: $isSingleDateMode, skipWeekends: $skipWeekends, submitAttendance: $submitAttendance, submitWorklog: $submitWorklog)';
}


}

/// @nodoc
abstract mixin class $AttendanceCompletedCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory $AttendanceCompletedCopyWith(AttendanceCompleted value, $Res Function(AttendanceCompleted) _then) = _$AttendanceCompletedCopyWithImpl;
@override @useResult
$Res call({
 List<String> logs, String? savedToken, DateTime? startDate, DateTime? endDate, bool saveTokenLocally, bool isSingleDateMode, bool skipWeekends, bool submitAttendance, bool submitWorklog
});




}
/// @nodoc
class _$AttendanceCompletedCopyWithImpl<$Res>
    implements $AttendanceCompletedCopyWith<$Res> {
  _$AttendanceCompletedCopyWithImpl(this._self, this._then);

  final AttendanceCompleted _self;
  final $Res Function(AttendanceCompleted) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? logs = null,Object? savedToken = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? saveTokenLocally = null,Object? isSingleDateMode = null,Object? skipWeekends = null,Object? submitAttendance = null,Object? submitWorklog = null,}) {
  return _then(AttendanceCompleted(
logs: null == logs ? _self._logs : logs // ignore: cast_nullable_to_non_nullable
as List<String>,savedToken: freezed == savedToken ? _self.savedToken : savedToken // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,saveTokenLocally: null == saveTokenLocally ? _self.saveTokenLocally : saveTokenLocally // ignore: cast_nullable_to_non_nullable
as bool,isSingleDateMode: null == isSingleDateMode ? _self.isSingleDateMode : isSingleDateMode // ignore: cast_nullable_to_non_nullable
as bool,skipWeekends: null == skipWeekends ? _self.skipWeekends : skipWeekends // ignore: cast_nullable_to_non_nullable
as bool,submitAttendance: null == submitAttendance ? _self.submitAttendance : submitAttendance // ignore: cast_nullable_to_non_nullable
as bool,submitWorklog: null == submitWorklog ? _self.submitWorklog : submitWorklog // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class AttendanceError implements AttendanceState {
  const AttendanceError({required this.message, required  List<String> logs, this.savedToken, this.startDate, this.endDate, this.saveTokenLocally = true, this.isSingleDateMode = false, this.skipWeekends = true, this.submitAttendance = true, this.submitWorklog = false}): _logs = logs;
  

 final  String message;
 final  List<String> _logs;
@override List<String> get logs {
  if (_logs is EqualUnmodifiableListView) return _logs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_logs);
}

@override final  String? savedToken;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override@JsonKey() final  bool saveTokenLocally;
@override@JsonKey() final  bool isSingleDateMode;
@override@JsonKey() final  bool skipWeekends;
@override@JsonKey() final  bool submitAttendance;
@override@JsonKey() final  bool submitWorklog;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceErrorCopyWith<AttendanceError> get copyWith => _$AttendanceErrorCopyWithImpl<AttendanceError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceError&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._logs, _logs)&&(identical(other.savedToken, savedToken) || other.savedToken == savedToken)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.saveTokenLocally, saveTokenLocally) || other.saveTokenLocally == saveTokenLocally)&&(identical(other.isSingleDateMode, isSingleDateMode) || other.isSingleDateMode == isSingleDateMode)&&(identical(other.skipWeekends, skipWeekends) || other.skipWeekends == skipWeekends)&&(identical(other.submitAttendance, submitAttendance) || other.submitAttendance == submitAttendance)&&(identical(other.submitWorklog, submitWorklog) || other.submitWorklog == submitWorklog));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_logs),savedToken,startDate,endDate,saveTokenLocally,isSingleDateMode,skipWeekends,submitAttendance,submitWorklog);

@override
String toString() {
  return 'AttendanceState.error(message: $message, logs: $logs, savedToken: $savedToken, startDate: $startDate, endDate: $endDate, saveTokenLocally: $saveTokenLocally, isSingleDateMode: $isSingleDateMode, skipWeekends: $skipWeekends, submitAttendance: $submitAttendance, submitWorklog: $submitWorklog)';
}


}

/// @nodoc
abstract mixin class $AttendanceErrorCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory $AttendanceErrorCopyWith(AttendanceError value, $Res Function(AttendanceError) _then) = _$AttendanceErrorCopyWithImpl;
@override @useResult
$Res call({
 String message, List<String> logs, String? savedToken, DateTime? startDate, DateTime? endDate, bool saveTokenLocally, bool isSingleDateMode, bool skipWeekends, bool submitAttendance, bool submitWorklog
});




}
/// @nodoc
class _$AttendanceErrorCopyWithImpl<$Res>
    implements $AttendanceErrorCopyWith<$Res> {
  _$AttendanceErrorCopyWithImpl(this._self, this._then);

  final AttendanceError _self;
  final $Res Function(AttendanceError) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? logs = null,Object? savedToken = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? saveTokenLocally = null,Object? isSingleDateMode = null,Object? skipWeekends = null,Object? submitAttendance = null,Object? submitWorklog = null,}) {
  return _then(AttendanceError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,logs: null == logs ? _self._logs : logs // ignore: cast_nullable_to_non_nullable
as List<String>,savedToken: freezed == savedToken ? _self.savedToken : savedToken // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,saveTokenLocally: null == saveTokenLocally ? _self.saveTokenLocally : saveTokenLocally // ignore: cast_nullable_to_non_nullable
as bool,isSingleDateMode: null == isSingleDateMode ? _self.isSingleDateMode : isSingleDateMode // ignore: cast_nullable_to_non_nullable
as bool,skipWeekends: null == skipWeekends ? _self.skipWeekends : skipWeekends // ignore: cast_nullable_to_non_nullable
as bool,submitAttendance: null == submitAttendance ? _self.submitAttendance : submitAttendance // ignore: cast_nullable_to_non_nullable
as bool,submitWorklog: null == submitWorklog ? _self.submitWorklog : submitWorklog // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
