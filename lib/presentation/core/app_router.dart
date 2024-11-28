import 'package:auto_route/auto_route.dart';
import 'package:e_dashboard/presentation/core/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashPage.page, initial: true),
        AutoRoute(page: DashboardView.page),
        AutoRoute(page: LoginView.page),
        AutoRoute(page: RegisterView.page),
      ];
}
