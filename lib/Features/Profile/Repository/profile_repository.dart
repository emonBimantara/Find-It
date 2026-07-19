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

  Future<Map<String, int>> getReportCount() async {
    final user = SupabaseService.client.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    final items = await SupabaseService.client
        .from("items")
        .select("category")
        .eq("user_id", user.id);

    final lost = items.where((e) => e["category"] == "lost").length;
    final found = items.where((e) => e["category"] == "found").length;

    return {"lost": lost, "found": found};
  }
}
