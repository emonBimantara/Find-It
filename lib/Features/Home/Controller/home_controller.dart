import 'package:findit/Features/Auth/Repository/supabase_service.dart';
import 'package:findit/Features/Home/Model/item_model.dart';
import 'package:findit/Features/Home/Repository/home_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final HomeRepository _repository;
  HomeController(this._repository);

  final username = "".obs;
  final items = <ItemModel>[].obs;
  final isLoading = false.obs;

  final selectedCategory = "all".obs;

  final searchController = TextEditingController();
  final searchQuery = "".obs;

  @override
  void onInit() {
    super.onInit();

    loadUser();
    fetchItems();

    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
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

  List<ItemModel> get filteredItems {
    return items.where((item) {
      final matchCategory =
          selectedCategory.value == "all" ||
          item.category.toLowerCase() == selectedCategory.value.toLowerCase();

      final matchSearch = item.title.toLowerCase().contains(
        searchQuery.value.toLowerCase(),
      );

      return matchCategory && matchSearch;
    }).toList();
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

}
