import 'package:findit/Features/Auth/Repository/auth_repository.dart';
import 'package:findit/Features/Home/Controller/home_controller.dart';
import 'package:findit/Routes/app_routes.dart';
import 'package:findit/Utils/auth_error_message.dart';
import 'package:findit/Utils/snackbar_helper.dart';
import 'package:findit/Utils/phone_number_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AuthController extends GetxController {
  final AuthRepository _repository;
  AuthController(this._repository);

  final isLogin = true.obs;
  final isLoading = false.obs;

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final registerUsernameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  final registerPhoneNumberController = TextEditingController();

  Future<void> login(BuildContext context) async {
    isLoading.value = true;

    try {
      if (loginEmailController.text.trim().isEmpty) {
        throw Exception("Email is required");
      }

      if (loginPasswordController.text.isEmpty) {
        throw Exception("Password is required");
      }

      await _repository.login(
        email: loginEmailController.text.trim(),
        password: loginPasswordController.text,
      );

      SnackbarHelper.success(context, "Login successful");

      context.go(AppRoutes.homePage);
    } catch (e) {
      SnackbarHelper.error(context, AuthErrorMessage.getMessage(e));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(BuildContext context) async {
    isLoading.value = true;

    final phone = PhoneNumberHelper.normalize(
      registerPhoneNumberController.text,
    );

    try {
      if (registerUsernameController.text.trim().isEmpty) {
        throw Exception("Username is required");
      }

      if (registerEmailController.text.trim().isEmpty) {
        throw Exception("Email is required");
      }

      if (registerPasswordController.text.isEmpty) {
        throw Exception("Password is required");
      }

      if (registerConfirmPasswordController.text.isEmpty) {
        throw Exception("Confirm password is required");
      }

      if (registerPasswordController.text !=
          registerConfirmPasswordController.text) {
        throw Exception("Passwords do not match");
      }

      if (registerPhoneNumberController.text.trim().isEmpty) {
        throw Exception("WhatsApp number is required");
      }

      if (!RegExp(r'^628\d{8,13}$').hasMatch(phone)) {
        throw Exception("Please enter a valid WhatsApp number.");
      }

      await _repository.register(
        username: registerUsernameController.text.trim(),
        email: registerEmailController.text.trim(),
        password: registerPasswordController.text,
        phoneNumber: phone,
      );

      SnackbarHelper.success(context, "Account created successfully");

      isLogin.value = true;
    } catch (e) {
      SnackbarHelper.error(context, AuthErrorMessage.getMessage(e));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await _repository.logout();

      if (Get.isRegistered<HomeController>()) {
        Get.delete<HomeController>();
      }

      SnackbarHelper.success(context, "Logged out successfully.");

      context.go(AppRoutes.authPage);
    } catch (e) {
      SnackbarHelper.error(context, "Failed to logout.");
    }
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();

    registerUsernameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    registerPhoneNumberController.dispose();

    super.onClose();
  }
}
