import 'package:findit/Features/Auth/Binding/auth_binding.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();
  }
}
