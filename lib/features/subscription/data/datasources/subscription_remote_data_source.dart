import '../models/subscription_plan_model.dart';
import '../models/subscription_service_model.dart';

abstract class SubscriptionRemoteDataSource {
  Future<SubscriptionServiceModel> getSubscriptionService();
}

class MockSubscriptionRemoteDataSourceImpl
    implements SubscriptionRemoteDataSource {
  @override
  Future<SubscriptionServiceModel> getSubscriptionService() async {
    await Future.delayed(const Duration(milliseconds: 800));

    return const SubscriptionServiceModel(
      name: 'EcoPlus',
      description: 'Upgrade to EcoPlus to control your lights from anywhere.',
      benefits: [
        'Unlimited remote access',
        'Convert six lights to dimmers',
        'Alexa / Google Assistant Integration',
      ],
      plans: [
        SubscriptionPlanModel(
          id: 'yearly_plan',
          title: 'Billed Yearly',
          priceDetail: '\$29.99 / year',
          pricePerWeek: '\$0.57 / week',
          trialPeriod: '3-MONTH',
          isSelected: true,
        ),
        SubscriptionPlanModel(
          id: 'monthly_plan',
          title: 'Billed Monthly',
          priceDetail: '\$2.99 / month',
          pricePerWeek: '\$0.69 / week',
          isSelected: false,
        ),
      ],
    );
  }
}
