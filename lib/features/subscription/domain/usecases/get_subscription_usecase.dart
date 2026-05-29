import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/subscription_entity.dart';
import '../repositories/subscription_repository.dart';

class GetSubscriptionUsecase implements UseCase<SubscriptionEntity, NoParams> {
  final SubscriptionRepository repository;

  GetSubscriptionUsecase(this.repository);

  @override
  Future<Either<Failure, SubscriptionEntity>> call(NoParams params) async {
    return await repository.getSubscriptionService();
  }
}
