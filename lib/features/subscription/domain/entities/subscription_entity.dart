import 'package:equatable/equatable.dart';

import 'subscription_plan_entity.dart';

class SubscriptionEntity extends Equatable {
  final String name;
  final String description;
  final List<String> benefits;
  final List<SubscriptionPlanEntity> plans;

  const SubscriptionEntity({
    required this.name,
    required this.description,
    required this.benefits,
    required this.plans,
  });

  @override
  List<Object?> get props => [name, description, benefits, plans];
}
