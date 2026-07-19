import 'package:findit/Features/Profile/Controller/profile_controller.dart';
import 'package:findit/Features/Profile/Repository/profile_repository.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileRepository());

    Get.lazyPut(() => ProfileController(Get.find<ProfileRepository>()));
  }
}
