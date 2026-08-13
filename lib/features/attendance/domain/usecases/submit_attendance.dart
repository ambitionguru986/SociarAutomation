import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/attendance_repository.dart';

@lazySingleton
class SubmitAttendance implements UseCase<void, ApiParams> {
  final AttendanceRepository repository;

  SubmitAttendance({required this.repository});

  @override
  Future<Either<Failure, void>> call(ApiParams params) async {
    return repository.submitAttendance(
      params.date,
      params.token,
      params.reason,
    );
  }
}

class ApiParams extends Equatable {
  final String date;
  final String token;
  final String reason;

  const ApiParams({
    required this.date,
    required this.token,
    this.reason = '',
  });

  @override
  List<Object> get props => [date, token, reason];
}
