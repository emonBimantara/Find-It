import 'package:findit/Features/Home/Controller/home_controller.dart';
import 'package:findit/Features/Home/Repository/home_repository.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeRepository>(() => HomeRepository());

    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<HomeRepository>()),
    );
  }
}
