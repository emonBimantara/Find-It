import 'package:findit/Features/Auth/Repository/supabase_service.dart';
import 'package:findit/Features/Home/Model/item_model.dart';

class HomeRepository {
  Future<List<ItemModel>> getItems() async {
    final resp = await SupabaseService.client.from("items").select();
    return resp.map<ItemModel>((json) => ItemModel.fromJson(json)).toList();
  }
}
