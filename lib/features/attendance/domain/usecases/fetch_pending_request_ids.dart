import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/attendance_repository.dart';

@lazySingleton
class FetchPendingRequestIds implements UseCase<List<int>, TokenParams> {
  final AttendanceRepository repository;

  FetchPendingRequestIds({required this.repository});

  @override
  Future<Either<Failure, List<int>>> call(TokenParams params) async {
    return repository.fetchPendingRequestIds(params.token);
  }
}

class TokenParams extends Equatable {
  final String token;

  const TokenParams({required this.token});

  @override
  List<Object> get props => [token];
}
