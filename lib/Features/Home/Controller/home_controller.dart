import 'package:findit/Features/Auth/Repository/supabase_service.dart';
import 'package:findit/Features/Home/Model/item_model.dart';
import 'package:findit/Features/Home/Repository/home_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final HomeRepository _repository;
  HomeController(this._repository);

  final username = "".obs;
  final items = <ItemModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    loadUser();
    fetchItems();
  }

  void loadUser() {
    final user = SupabaseService.client.auth.currentUser;
    username.value = user?.userMetadata?['username'] ?? "User";
  }

  Future<void> fetchItems() async {
    try {
      isLoading.value = true;
      final result = await _repository.getItems();
      items.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }
}
