import 'package:findit/Features/Auth/Binding/auth_binding.dart';
import 'package:findit/Features/Auth/View/auth_page.dart';
import 'package:findit/Features/Home/Bindings/home_binding.dart';
import 'package:findit/Features/Home/Model/item_model.dart';
import 'package:findit/Features/Home/View/home_page.dart';
import 'package:findit/Features/Home/View/view_all_page.dart';
import 'package:findit/Features/ItemDetail/Binding/item_detail_binding.dart';
import 'package:findit/Features/ItemDetail/Views/item_detail_page.dart';
import 'package:findit/Features/Onboarding/onboarding_page.dart';
import 'package:findit/Features/Profile/Views/profile_page.dart';
import 'package:findit/Features/Report/Binding/report_binding.dart';
import 'package:findit/Features/Report/Views/report_page.dart';
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
        return HomePage();
      },
    ),

    GoRoute(
      path: AppRoutes.reportPage,
      builder: (context, state) {
        ReportBinding().dependencies();
        return ReportPage();
      },
    ),

    GoRoute(
      path: AppRoutes.viewAllPage,
      builder: (context, state) => ViewAllPage(),
    ),

    GoRoute(
      path: AppRoutes.detailPage,
      builder: (context, state) {
        ItemDetailBinding().dependencies();
        final item = state.extra as ItemModel;
        return ItemDetailPage(item: item);
      },
    ),

    GoRoute(
      path: AppRoutes.profilePage,
      builder: (context, state) => ProfilePage(),
    ),

    // GoRoute(
    //   path: AppRoutes.historyPage,
    //   builder: (context, state) => HistoryPage(),
    // ),
  ],
);
