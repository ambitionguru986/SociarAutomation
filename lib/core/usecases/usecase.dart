import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:attendance_automator/core/error/failures.dart';

// Interface for all use cases with arguments
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

// Params class for use cases that take no arguments
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
