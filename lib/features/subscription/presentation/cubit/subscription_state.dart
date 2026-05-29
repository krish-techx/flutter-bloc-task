part of 'subscription_cubit.dart';

enum SubscriptionStatus {
  initial,
  loading,
  loaded,
  error,
  subscribing,
  subscribed,
}

enum SubscriptionScreen { benefits, plans }

class SubscriptionState extends Equatable {
  final SubscriptionStatus status;
  final SubscriptionEntity? subscriptionService;
  final String? selectedPlanId;
  final String? errorMessage;
  final SubscriptionScreen currentScreen;

  const SubscriptionState({
    this.status = SubscriptionStatus.initial,
    this.subscriptionService,
    this.selectedPlanId,
    this.errorMessage,
    this.currentScreen = SubscriptionScreen.benefits,
  });

  SubscriptionState copyWith({
    SubscriptionStatus? status,
    SubscriptionEntity? subscriptionService,
    String? selectedPlanId,
    String? errorMessage,
    SubscriptionScreen? currentScreen,
  }) {
    return SubscriptionState(
      status: status ?? this.status,
      subscriptionService: subscriptionService ?? this.subscriptionService,
      selectedPlanId: selectedPlanId ?? this.selectedPlanId,
      errorMessage: errorMessage ?? this.errorMessage,
      currentScreen: currentScreen ?? this.currentScreen,
    );
  }

  @override
  List<Object?> get props => [
    status,
    subscriptionService,
    selectedPlanId,
    errorMessage,
    currentScreen,
  ];
}
