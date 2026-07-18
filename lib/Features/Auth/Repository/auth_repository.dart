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
    required String username,
    required String phoneNumber
  }) async {
    final response = await SupabaseService.client.auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user == null) {
      throw Exception("Failed to create account.");
    }

    await SupabaseService.client.from('profiles').insert({
      'id': user.id,
      'username': username,
      'phone_number': phoneNumber,
    });
  }

  Future<void> logout() async {
    await SupabaseService.client.auth.signOut();
  }
}
