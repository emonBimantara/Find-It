import 'package:findit/Features/Auth/Controller/auth_controller.dart';
import 'package:findit/Widgets/custom_toggle_switch.dart';
import 'package:findit/Widgets/login_form.dart';
import 'package:findit/Widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SizedBox(height: 70),

              Image.asset("assets/Icon.png", height: 80),

              SizedBox(height: 10),

              Text(
                "FindIt",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),

              SizedBox(height: 6),

              Obx(
                () => Text(
                  authController.isLogin.value
                      ? "Welcome back. Enter your details to continue."
                      : "Create your account and start using FindIt.",
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      CustomToggleSwitch(
                        leftText: "Login",
                        rightText: "Register",
                        isLeftSelected: authController.isLogin.value,
                        onToggle: (value) {
                          authController.isLogin.value = value;
                        },
                      ),

                      SizedBox(height: 24),

                      AnimatedSwitcher(
                        duration: Duration.zero,
                        child: authController.isLogin.value
                            ? LoginForm(
                                key: const ValueKey("login"),
                                emailController:
                                    authController.loginEmailController,
                                passwordController:
                                    authController.loginPasswordController,
                                isLoading: authController.isLoading.value,
                                onLogin: () => authController.login(context),
                              )
                            : RegisterForm(
                                key: const ValueKey("register"),
                                usernameController:
                                    authController.registerUsernameController,
                                emailController:
                                    authController.registerEmailController,
                                passwordController:
                                    authController.registerPasswordController,
                                confirmPasswordController: authController
                                    .registerConfirmPasswordController,
                                isLoading: authController.isLoading.value,
                                onRegister: () =>
                                    authController.register(context),
                              ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              Text(
                "By continuing, you agree to our Terms of Service and\nPrivacy Policy.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
