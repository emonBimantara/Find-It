import 'package:findit/Routes/app_routes.dart';
import 'package:findit/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          "assets/onboard_img.png",
                          height: 350,
                        ),
                      ),

                      SizedBox(height: 24),

                      Text(
                        "Lost Something? Found Something?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color(0xFF141B2B),
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Report lost items, share found belongings, and help reunite people with what matters most—all in one trusted place.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF464555),
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: GestureDetector(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool("onboarding_done", true);

                  if (!context.mounted) return;

                  context.go(AppRoutes.authPage);
                },
                child: CustomButton(text: "Get Started"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
