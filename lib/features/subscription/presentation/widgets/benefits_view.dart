import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../../domain/entities/subscription_entity.dart';
import '../cubit/subscription_cubit.dart';

class BenefitsView extends StatelessWidget {
  final SubscriptionEntity? service;

  const BenefitsView({super.key, this.service});

  @override
  Widget build(BuildContext context) {
    final benefits = service?.benefits ?? [];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
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
                  service?.description ??
                      'Upgrade to ${service?.name} to control your lights from anywhere.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                ...benefits.map(
                  (benefit) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            benefit,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),
        PrimaryButton(
          text: 'UPGRADE TO ${service?.name.toUpperCase()}',
          onPressed: () => context.read<SubscriptionCubit>().goToPlans(),
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
