import 'package:findit/Features/Auth/Repository/supabase_service.dart';

class AuthRepository {
  Future<void> login({required String email, required String password}) async {
    await SupabaseService.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> register({
    required String email,
    required String password,
    required String username
  }) async {
    await SupabaseService.client.auth.signUp(
      email: email,
      password: password,
      data: {'username': username},
    );
  }

  Future<void> logout() async {
    await SupabaseService.client.auth.signOut();
  }
}
