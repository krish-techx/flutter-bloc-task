import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_colors.dart';
import 'features/subscription/data/datasources/subscription_remote_data_source.dart';
import 'features/subscription/data/repositories/subscription_repository_impl.dart';
import 'features/subscription/domain/usecases/get_subscription_usecase.dart';
import 'features/subscription/domain/usecases/subscribe_to_plan_usecase.dart';
import 'features/subscription/presentation/cubit/subscription_cubit.dart';
import 'features/subscription/presentation/pages/subscription_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.white,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Subscription Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => SubscriptionCubit(
          getSubscription: GetSubscriptionUsecase(
            SubscriptionRepositoryImpl(
              remoteDataSource: MockSubscriptionRemoteDataSourceImpl(),
            ),
          ),
          subscribeToPlan: SubscribeToPlanUsecase(
            SubscriptionRepositoryImpl(
              remoteDataSource: MockSubscriptionRemoteDataSourceImpl(),
            ),
          ),
        ),
        child: const SubscriptionPage(),
      ),
    );
  }
}
