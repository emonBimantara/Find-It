import 'package:findit/Features/ItemDetail/Controller/item_detail_controller.dart';
import 'package:get/get.dart';

class ItemDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ItemDetailController());
  }
}
