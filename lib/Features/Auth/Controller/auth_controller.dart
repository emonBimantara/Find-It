import 'package:findit/Features/Auth/Repository/auth_repository.dart';
import 'package:findit/Routes/app_routes.dart';
import 'package:findit/Utils/auth_error_message.dart';
import 'package:findit/Utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AuthController extends GetxController {
  final AuthRepository _repository = AuthRepository();

  final isLogin = true.obs;
  final isLoading = false.obs;

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final registerUsernameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

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

      await _repository.register(
        username: registerUsernameController.text.trim(),
        email: registerEmailController.text.trim(),
        password: registerPasswordController.text,
      );

      SnackbarHelper.success(context, "Account created successfully");

      isLogin.value = true;
    } catch (e) {
      SnackbarHelper.error(context, AuthErrorMessage.getMessage(e));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _repository.logout();
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();

    registerUsernameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();

    super.onClose();
  }
}
