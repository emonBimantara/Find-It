import 'package:findit/Features/Report/Controller/report_controller.dart';
import 'package:findit/Features/Report/Repository/report_repository.dart';
import 'package:get/get.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportRepository>(() => ReportRepository());

    Get.lazyPut<ReportController>(() => ReportController(Get.find()));
  }
}
