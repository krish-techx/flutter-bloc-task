import 'package:equatable/equatable.dart';

class SubscriptionEntity extends Equatable {
  final String id;
  final String title;
  final String priceDetail;
  final String pricePerWeek;
  final List<String> benefits;
  final String? trialPeriod;
  final bool isSelected;

  const SubscriptionEntity({
    required this.id,
    required this.title,
    required this.priceDetail,
    required this.pricePerWeek,
    required this.benefits,
    this.trialPeriod,
    this.isSelected = false,
  });

  SubscriptionEntity copyWith({
    String? id,
    String? title,
    String? priceDetail,
    String? pricePerWeek,
    List<String>? benefits,
    String? trialPeriod,
    bool? isSelected,
  }) {
    return SubscriptionEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      priceDetail: priceDetail ?? this.priceDetail,
      pricePerWeek: pricePerWeek ?? this.pricePerWeek,
      benefits: benefits ?? this.benefits,
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
    benefits,
    trialPeriod,
    isSelected,
  ];
}
