import 'package:findit/Features/Auth/Binding/auth_binding.dart';
import 'package:findit/Features/Auth/View/auth_page.dart';
import 'package:findit/Features/Home/Bindings/home_binding.dart';
import 'package:findit/Features/Home/View/home_page.dart';
import 'package:findit/Features/Onboarding/onboarding_page.dart';
import 'package:findit/Features/Splash/splash_screen.dart';
import 'package:findit/Routes/app_routes.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splashPage,
  routes: [
    GoRoute(
      path: AppRoutes.splashPage,
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: AppRoutes.onboardingPage,
      builder: (context, state) => const OnboardingPage(),
    ),

    GoRoute(
      path: AppRoutes.authPage,
      builder: (context, state) {
        AuthBinding().dependencies();
        return AuthPage();
      },
    ),

    GoRoute(
      path: AppRoutes.homePage,
      builder: (context, state) {
        HomeBinding().dependencies();
        return const HomePage();
      },
    ),
  ],
);
