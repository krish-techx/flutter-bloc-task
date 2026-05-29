import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../../domain/entities/subscription_entity.dart';
import '../../domain/entities/subscription_plan_entity.dart';
import '../cubit/subscription_cubit.dart';
import 'plan_tile.dart';

class PlansView extends StatelessWidget {
  final SubscriptionEntity? service;
  final String? selectedPlanId;

  const PlansView({super.key, this.service, this.selectedPlanId});

  @override
  Widget build(BuildContext context) {
    final List<SubscriptionPlanEntity> plans = service!.plans;
    SubscriptionPlanEntity? selectedPlan;

    try {
      selectedPlan = plans.firstWhere((p) => p.id == selectedPlanId);
    } catch (_) {
      selectedPlan = plans.isNotEmpty ? plans.first : null;
    }

    if (selectedPlan == null) {
      return const Center(
        child: Text(
          'No plans available',
          style: TextStyle(color: AppColors.white),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Get unlimited remote access',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Upgrade to ${service?.name} to control your lights from anywhere.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                ...plans.map(
                  (plan) => PlanTile(
                    plan: plan,
                    isSelected: plan.id == selectedPlanId,
                    onTap: () =>
                        context.read<SubscriptionCubit>().selectPlan(plan.id),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'By tapping the upgrade now button, you agree to Terms and Conditions. You also agree to recurring charge (\$) until you cancel.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.54),
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),
        PrimaryButton(
          text: 'START ${selectedPlan.trialPeriod ?? ''} FREE TRIAL',
          onPressed: () => context.read<SubscriptionCubit>().subscribe(),
        ),
        const SizedBox(height: 8),
        SecondaryButton(
          text: 'Already have ${service?.name}?',
          onPressed: () {},
        ),
      ],
    );
  }
}
