import '../../domain/entities/subscription_entity.dart';
import 'subscription_plan_model.dart';

class SubscriptionServiceModel extends SubscriptionEntity {
  const SubscriptionServiceModel({
    required super.name,
    required super.description,
    required super.benefits,
    required List<SubscriptionPlanModel> super.plans,
  });

  factory SubscriptionServiceModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionServiceModel(
      name: json['name'],
      description: json['description'],
      benefits: List<String>.from(json['benefits']),
      plans: (json['plans'] as List)
          .map((plan) => SubscriptionPlanModel.fromJson(plan))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'benefits': benefits,
      'plans': plans
          .map((plan) => (plan as SubscriptionPlanModel).toJson())
          .toList(),
    };
  }
}
