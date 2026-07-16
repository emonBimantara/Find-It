import 'package:findit/Features/Home/Model/item_model.dart';
import 'package:findit/Features/Home/Repository/item_repository.dart';

class HomeController {
  final ItemRepository _repository = ItemRepository();

  Future<List<ItemModel>> getItems() async {
    return await _repository.getItems();
  }
}