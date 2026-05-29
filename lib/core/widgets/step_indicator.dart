import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final Color? activeColor;
  final Color? inactiveColor;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: List.generate(totalSteps, (index) {
            final isActive = index == currentStep;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: isActive ? 18 : 8,
              decoration: BoxDecoration(
                gradient: isActive
                    ? const LinearGradient(
                        colors: [AppColors.primary, AppColors.secondary],
                      )
                    : null,
                color: isActive
                    ? null
                    : (inactiveColor ?? Colors.white.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(10),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: AppColors.white.withValues(alpha: 0.45),
                          blurRadius: 1,
                          spreadRadius: 1.2,
                        ),
                      ]
                    : null,
              ),
            );
          }),
        ),
      ],
    );
  }
}
