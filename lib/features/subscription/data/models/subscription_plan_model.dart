import '../../domain/entities/subscription_plan_entity.dart';

class SubscriptionPlanModel extends SubscriptionPlanEntity {
  const SubscriptionPlanModel({
    required super.id,
    required super.title,
    required super.priceDetail,
    required super.pricePerWeek,
    super.trialPeriod,
    super.isSelected,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanModel(
      id: json['id'],
      title: json['title'],
      priceDetail: json['priceDetail'],
      pricePerWeek: json['pricePerWeek'],
      trialPeriod: json['trialPeriod'],
      isSelected: json['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'priceDetail': priceDetail,
      'pricePerWeek': pricePerWeek,
      'trialPeriod': trialPeriod,
      'isSelected': isSelected,
    };
  }
}
