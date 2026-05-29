import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/subscription_entity.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../datasources/subscription_remote_data_source.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionRemoteDataSource remoteDataSource;

  SubscriptionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, SubscriptionEntity>> getSubscriptionService() async {
    try {
      final service = await remoteDataSource.getSubscriptionService();
      return Right(service);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> subscribeToPlan(String planId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
