// import 'package:findit/Components/auth_form.dart';
// import 'package:findit/Routes/app_routes.dart';
// import 'package:findit/Widgets/auth_switch.dart';
// import 'package:findit/Widgets/custom_button.dart';
// import 'package:findit/Widgets/custom_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF9F9FF),
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Image.asset("assets/Icon.png", height: 80),
//                   SizedBox(height: 10),
//                   Column(
//                     children: [
//                       Text(
//                         "FindIt",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 30,
//                         ),
//                       ),
//                       Text(
//                         "Welcome back. Enter your details to continue.",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   AuthForm(
//                     children: [
//                       AuthSwitch(
//                         isLogin: true,
//                         onLoginTap: () {},
//                         onRegisterTap: () {
//                           context.go(AppRoutes.registerPage);
//                         },
//                       ),
//                       SizedBox(height: 24),

//                       Text(
//                         "Email Address",
//                         style: TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                       SizedBox(height: 10),

//                       CustomTextField(hintText: 'johndoe@gmail.com'),
//                       SizedBox(height: 20),

//                       Text(
//                         "Password",
//                         style: TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                       SizedBox(height: 10),

//                       CustomTextField(hintText: "********", obscureText: true),
//                       SizedBox(height: 8),

//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: GestureDetector(
//                           onTap: () {},
//                           child: Text(
//                             "Forgot Password?",
//                             style: TextStyle(
//                               color: Color(0xFF3525CD),
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 24),

//                       CustomButton(text: "Login"),
//                     ],
//                   ),
//                   SizedBox(height: 20),

//                   RichText(
//                     textAlign: TextAlign.center,
//                     text: TextSpan(
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Color(0xFF6B7280),
//                         height: 1.5,
//                       ),
//                       children: [
//                         TextSpan(
//                           text: "By continuing, you agree to our ",
//                         ),
//                         TextSpan(
//                           text: "Terms of Service",
//                           style: const TextStyle(
//                             color: Color(0xFF3525CD),
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         TextSpan(text: " and\n"),
//                         TextSpan(
//                           text: "Privacy Policy.",
//                           style: const TextStyle(
//                             color: Color(0xFF3525CD),
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
