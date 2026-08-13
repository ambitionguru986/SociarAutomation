import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/attendance_repository.dart';

@lazySingleton
class GetToken implements UseCase<String?, NoParams> {
  final AttendanceRepository repository;

  GetToken({required this.repository});

  @override
  Future<Either<Failure, String?>> call(NoParams params) async {
    return repository.getToken();
  }
}
