import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/attendance_repository.dart';

@lazySingleton
class SaveToken implements UseCase<void, String> {
  final AttendanceRepository repository;

  SaveToken({required this.repository});

  @override
  Future<Either<Failure, void>> call(String token) async {
    return repository.saveToken(token);
  }
}
