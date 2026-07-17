import 'package:findit/Widgets/custom_button.dart';
import 'package:findit/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey("login"),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Email Address",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 10),

        CustomTextField(
          controller: emailController,
          hintText: "johndoe@gmail.com",
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          prefixIcon: Icon(Icons.email_outlined),
        ),

        SizedBox(height: 20),

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Password",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),

        SizedBox(height: 10),

        CustomTextField(
          controller: passwordController,
          hintText: "********",
          obscureText: true,
          prefixIcon: Icon(Icons.lock_outline),
        ),

        SizedBox(height: 8),

        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Forgot Password?",
            style: TextStyle(
              color: Color(0xFF3525CD),
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),

        SizedBox(height: 24),

        CustomButton(text: "Login", onPressed: onLogin, isLoading: isLoading),
      ],
    );
  }
}
