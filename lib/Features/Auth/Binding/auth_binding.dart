import 'package:findit/Features/Auth/Controller/auth_controller.dart';
import 'package:findit/Features/Auth/Repository/auth_repository.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());

    Get.lazyPut<AuthController>(
      () => AuthController(Get.find<AuthRepository>()),
    );
  }
}
