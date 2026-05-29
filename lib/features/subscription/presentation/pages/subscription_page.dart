import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../cubit/subscription_cubit.dart';
import '../widgets/benefits_view.dart';
import '../widgets/glass_card.dart';
import '../widgets/plans_view.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  late PageController _pageController;
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _videoController = VideoPlayerController.asset('assets/sample.mp4')
      ..initialize()
          .then((_) async {
            await _videoController.setLooping(true);
            await _videoController.play();
            await _videoController.setVolume(0);
            if (mounted) setState(() {});
          })
          .catchError((error) {
            debugPrint('Video player error: $error');
            if (mounted) {
              setState(() {});
            }
          });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SubscriptionCubit, SubscriptionState>(
        listener: (context, state) {
          final targetPage = state.currentScreen == SubscriptionScreen.benefits
              ? 0
              : 1;
          if (_pageController.hasClients &&
              _pageController.page?.round() != targetPage) {
            _pageController.animateToPage(
              targetPage,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        },
        builder: (context, state) {
          if (state.status == SubscriptionStatus.initial) {
            context.read<SubscriptionCubit>().loadSubscriptionData();
          }

          return Stack(
            clipBehavior: Clip.none,
            children: [
              // Background
              Positioned.fill(
                child: _videoController.value.isInitialized
                    ? FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _videoController.value.size.width,
                          height: _videoController.value.size.height,
                          child: VideoPlayer(_videoController),
                        ),
                      )
                    : _videoController.value.hasError
                    ? Container(
                        color: Colors.black,
                        child: const Center(
                          child: Text(
                            'Video failed to load\nCheck your internet connection',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      )
                    : Container(color: Colors.black),
              ),
              Positioned.fill(
                child: Container(color: Colors.black.withValues(alpha: 0.3)),
              ),

              Column(
                children: [
                  // Header
                  CustomAppBar(
                    title: '123 Oak Grove Dr.',
                    actions: [
                      IconButton(
                        icon: const Icon(
                          Icons.settings_outlined,
                          color: AppColors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const Spacer(),

                  // Content
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GlassCard(
                      currentStep:
                          state.currentScreen == SubscriptionScreen.benefits
                          ? 0
                          : 1,
                      totalSteps: 2,
                      child: _buildSubscriptionContent(context, state),
                    ),
                  ),
                  const SizedBox(height: kToolbarHeight),
                ],
              ),

              if (state.status == SubscriptionStatus.loading ||
                  state.status == SubscriptionStatus.subscribing)
                const Positioned.fill(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.white),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSubscriptionContent(
    BuildContext context,
    SubscriptionState state,
  ) {
    if (state.status == SubscriptionStatus.initial ||
        state.status == SubscriptionStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.white),
      );
    }

    if (state.status == SubscriptionStatus.error) {
      return Center(
        child: Text(
          state.errorMessage ?? 'Something went wrong, please try again',
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.white),
        ),
      );
    }

    if (state.subscriptionService == null) {
      return const Center(
        child: Text(
          'No subscription data available',
          style: TextStyle(color: AppColors.white),
        ),
      );
    }

    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        if (index == 0) {
          context.read<SubscriptionCubit>().goToBenefits();
        } else {
          context.read<SubscriptionCubit>().goToPlans();
        }
      },
      children: [
        BenefitsView(service: state.subscriptionService),
        PlansView(
          service: state.subscriptionService,
          selectedPlanId: state.selectedPlanId,
        ),
      ],
    );
  }
}
