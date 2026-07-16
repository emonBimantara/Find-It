import 'package:findit/Features/Auth/Controller/auth_controller.dart';
import 'package:findit/Routes/app_routes.dart';
import 'package:findit/Widgets/auth_switch.dart';
import 'package:findit/Widgets/login_form.dart';
import 'package:findit/Widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  final AuthController authController = AuthController();

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final registerUsernameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();

    registerUsernameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> handleLogin() async {
      try {
        await authController.login(
          email: loginEmailController.text,
          password: loginPasswordController.text,
        );
        
        context.go(AppRoutes.homePage);
        
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Login successful")));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
        );
      }
    }

    Future<void> handleRegister() async {
      try {
        await authController.register(
          username: registerUsernameController.text,
          email: registerEmailController.text,
          password: registerPasswordController.text,
          confirmPassword: registerConfirmPasswordController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account created successfully")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
        );
      }
    }

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

              Text(
                isLogin
                    ? "Welcome back. Enter your details to continue."
                    : "Create your account and start using FindIt.",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Column(
                  children: [
                    AuthSwitch(
                      isLogin: isLogin,

                      onLoginTap: () {
                        setState(() {
                          isLogin = true;
                        });
                      },

                      onRegisterTap: () {
                        setState(() {
                          isLogin = false;
                        });
                      },
                    ),
                    SizedBox(height: 24),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      child: isLogin
                          ? LoginForm(
                              emailController: loginEmailController,
                              passwordController: loginPasswordController,
                              onLogin: handleLogin,
                            )
                          : RegisterForm(
                              usernameController: registerUsernameController,
                              emailController: registerEmailController,
                              passwordController: registerPasswordController,
                              confirmPasswordController: registerConfirmPasswordController,
                              onRegister: handleRegister,
                            ),
                    ),
                  ],
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
