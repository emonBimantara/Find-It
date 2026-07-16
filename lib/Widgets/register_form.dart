import 'package:findit/Widgets/custom_button.dart';
import 'package:findit/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final VoidCallback onRegister;

  const RegisterForm({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey("register"),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Username",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 10),

        CustomTextField(
          controller: usernameController,
          hintText: "johndoe",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          prefixIcon: Icon(Icons.person),
        ),

        SizedBox(height: 20),

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

        SizedBox(height: 20),

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Confirm Password",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 10),

        CustomTextField(
          controller: confirmPasswordController,
          hintText: "********",
          obscureText: true,
          prefixIcon: Icon(Icons.lock_outline),
        ),

        SizedBox(height: 24),

        CustomButton(text: "Create Account", onPressed: onRegister),
      ],
    );
  }
}
