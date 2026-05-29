import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/subscription_entity.dart';

abstract class SubscriptionRepository {
  Future<Either<Failure, SubscriptionEntity>> getSubscriptionService();

  Future<Either<Failure, bool>> subscribeToPlan(String planId);
}
