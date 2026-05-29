import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/subscription_repository.dart';

class SubscribeToPlan implements UseCase<bool, SubscribeParams> {
  final SubscriptionRepository repository;

  SubscribeToPlan(this.repository);

  @override
  Future<Either<Failure, bool>> call(SubscribeParams params) async {
    return await repository.subscribeToPlan(params.subscriptionId);
  }
}

class SubscribeParams extends Equatable {
  final String subscriptionId;

  const SubscribeParams({required this.subscriptionId});

  @override
  List<Object?> get props => [subscriptionId];
}
