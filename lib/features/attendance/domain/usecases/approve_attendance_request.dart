import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/attendance_repository.dart';

@lazySingleton
class ApproveAttendanceRequest implements UseCase<void, ApproveParams> {
  final AttendanceRepository repository;

  ApproveAttendanceRequest({required this.repository});

  @override
  Future<Either<Failure, void>> call(ApproveParams params) async {
    return repository.approveAttendanceRequest(params.id, params.token);
  }
}

class ApproveParams extends Equatable {
  final int id;
  final String token;

  const ApproveParams({required this.id, required this.token});

  @override
  List<Object> get props => [id, token];
}
