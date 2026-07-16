import 'package:findit/Features/Auth/Repository/auth_repository.dart';

class AuthController {
  final AuthRepository _repository = AuthRepository();

  Future<void> login({required String email, required String password}) async {
    if (email.trim().isEmpty) {
      throw Exception("Email is required");
    }

    if (password.isEmpty) {
      throw Exception("Password is required");
    }

    await _repository.login(email: email, password: password);
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (username.trim().isEmpty) {
      throw Exception("Username is required");
    }

    if (email.trim().isEmpty) {
      throw Exception("Email is required");
    }

    if (password.isEmpty) {
      throw Exception("Password is required");
    }

    if (confirmPassword.isEmpty) {
      throw Exception("Confirm Password is required");
    }

    if (password != confirmPassword) {
      throw Exception("Passwords do not match");
    }

    await _repository.register(
      username: username,
      email: email,
      password: password,
    );
  }
}
