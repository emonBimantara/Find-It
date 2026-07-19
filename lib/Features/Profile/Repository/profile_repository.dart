import 'package:findit/Features/Auth/Repository/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:findit/Features/Profile/Model/profile_model.dart';
import 'dart:io';

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

  Future<String> uploadAvatar(File image) async {
    final user = SupabaseService.client.auth.currentUser!;

    final profile = await SupabaseService.client
        .from("profiles")
        .select("avatar_url")
        .eq("id", user.id)
        .single();

    final oldAvatarUrl = profile["avatar_url"] as String?;

    if (oldAvatarUrl != null && oldAvatarUrl.isNotEmpty) {
      try {
        final oldPath = oldAvatarUrl
            .split("/storage/v1/object/public/avatars/")
            .last;

        await SupabaseService.client.storage.from("avatars").remove([oldPath]);
      } catch (e) {
        print("Delete old avatar failed: $e");
      }
    }

    final filePath =
        "${user.id}/avatar_${DateTime.now().millisecondsSinceEpoch}.jpg";

    await SupabaseService.client.storage
        .from("avatars")
        .upload(filePath, image, fileOptions: const FileOptions(upsert: false));

    final imageUrl = SupabaseService.client.storage
        .from("avatars")
        .getPublicUrl(filePath);

    await SupabaseService.client
        .from("profiles")
        .update({"avatar_url": imageUrl})
        .eq("id", user.id);

    return imageUrl;
  }
}
