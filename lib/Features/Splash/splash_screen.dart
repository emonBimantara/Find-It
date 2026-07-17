import 'package:findit/Features/Auth/Repository/supabase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:findit/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAppState();
  }

  Future<void> _checkAppState() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final onboardingDone = prefs.getBool("onboarding_done") ?? false;

    if (!onboardingDone) {
      context.go(AppRoutes.onboardingPage);
      return;
    }

    final session = SupabaseService.client.auth.currentSession;

    if (session != null) {
      context.go(AppRoutes.homePage);
    } else {
      context.go(AppRoutes.authPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/Icon.png", height: 150),
            const SizedBox(height: 24),
            const Column(
              children: [
                Text(
                  "FindIt",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Color(0xFF3525CD),
                  ),
                ),
                Text(
                  "Lost & Found. Reimagined",
                  style: TextStyle(
                    color: Color(0xFF464555),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
