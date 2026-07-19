import 'package:findit/Features/Auth/Repository/supabase_service.dart';
import 'package:findit/Features/Profile/Model/profile_model.dart';

class ProfileRepository {
  Future<ProfileModel> getProfile() async {
    final user = SupabaseService.client.auth.currentUser!;

    final profile = await SupabaseService.client
        .from("profiles")
        .select()
        .eq("id", user.id)
        .single();

    return ProfileModel.fromJson(profile, user.email ?? "");
  }
}
