import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/subscription_entity.dart';
import '../repositories/subscription_repository.dart';

class GetSubscriptionPlans
    implements UseCase<List<SubscriptionEntity>, NoParams> {
  final SubscriptionRepository repository;

  GetSubscriptionPlans(this.repository);

  @override
  Future<Either<Failure, List<SubscriptionEntity>>> call(
    NoParams params,
  ) async {
    return await repository.getSubscriptionPlans();
  }
}
