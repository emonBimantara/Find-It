import 'package:findit/Features/Auth/Repository/supabase_service.dart';
import 'package:findit/Features/Home/Model/item_model.dart';

class HomeRepository {
  Future<List<ItemModel>> getItems() async {
    final resp = await SupabaseService.client.from("items").select('''
      *,
      profiles (
        username
      )
    ''');

    return resp.map<ItemModel>((json) => ItemModel.fromJson(json)).toList();
  }

  Future<String> getUsername() async {
    try {
      final user = SupabaseService.client.auth.currentUser;

      if (user == null) {
        return "User";
      }

      final profile = await SupabaseService.client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      return profile['username'] ?? "User";
    } catch (e, stackTrace) {
      return "User";
    }
  }
}
