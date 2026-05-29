import 'package:equatable/equatable.dart';

class SubscriptionPlanEntity extends Equatable {
  final String id;
  final String title;
  final String priceDetail;
  final String pricePerWeek;
  final String? trialPeriod;
  final bool isSelected;

  const SubscriptionPlanEntity({
    required this.id,
    required this.title,
    required this.priceDetail,
    required this.pricePerWeek,
    this.trialPeriod,
    this.isSelected = false,
  });

  SubscriptionPlanEntity copyWith({
    String? id,
    String? title,
    String? priceDetail,
    String? pricePerWeek,
    String? trialPeriod,
    bool? isSelected,
  }) {
    return SubscriptionPlanEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      priceDetail: priceDetail ?? this.priceDetail,
      pricePerWeek: pricePerWeek ?? this.pricePerWeek,
      trialPeriod: trialPeriod ?? this.trialPeriod,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    priceDetail,
    pricePerWeek,
    trialPeriod,
    isSelected,
  ];
}
