import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/subscription_entity.dart';
import '../../domain/usecases/get_subscription_usecase.dart';
import '../../domain/usecases/subscribe_to_plan_usecase.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final GetSubscriptionUsecase getSubscription;
  final SubscribeToPlanUsecase subscribeToPlan;

  SubscriptionCubit({
    required this.getSubscription,
    required this.subscribeToPlan,
  }) : super(const SubscriptionState());

  Future<void> loadSubscriptionData() async {
    if (state.status == SubscriptionStatus.loading) return;

    emit(state.copyWith(status: SubscriptionStatus.loading));

    final result = await getSubscription(NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SubscriptionStatus.error,
          errorMessage: 'Failed to load subscription data',
        ),
      ),
      (service) {
        if (service.plans.isEmpty) {
          emit(
            state.copyWith(
              status: SubscriptionStatus.error,
              errorMessage: 'No plans available',
            ),
          );
          return;
        }

        final selectedPlan = service.plans.any((p) => p.isSelected)
            ? service.plans.firstWhere((p) => p.isSelected)
            : service.plans.first;

        emit(
          state.copyWith(
            status: SubscriptionStatus.loaded,
            subscriptionService: service,
            selectedPlanId: selectedPlan.id,
          ),
        );
      },
    );
  }

  void selectPlan(String planId) {
    emit(state.copyWith(selectedPlanId: planId));
  }

  void goToPlans() {
    emit(state.copyWith(currentScreen: SubscriptionScreen.plans));
  }

  void goToBenefits() {
    emit(state.copyWith(currentScreen: SubscriptionScreen.benefits));
  }

  Future<void> subscribe() async {
    if (state.selectedPlanId == null ||
        state.status == SubscriptionStatus.subscribing) {
      return;
    }

    emit(state.copyWith(status: SubscriptionStatus.subscribing));

    final result = await subscribeToPlan(
      SubscribeParams(subscriptionId: state.selectedPlanId!),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SubscriptionStatus.error,
          errorMessage: 'Subscription failed. Please try again.',
        ),
      ),
      (success) => emit(state.copyWith(status: SubscriptionStatus.subscribed)),
    );
  }
}
