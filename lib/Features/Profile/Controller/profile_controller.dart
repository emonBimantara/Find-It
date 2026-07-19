import 'package:findit/Features/Profile/Model/profile_model.dart';
import 'package:findit/Features/Profile/Repository/profile_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final ProfileRepository repository;
  ProfileController(this.repository);

  final isLoading = false.obs;

  final profile = Rxn<ProfileModel>();
  final lostCount = 0.obs;
  final foundCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;

      profile.value = await repository.getProfile();

      final count = await repository.getReportCount();

      lostCount.value = count["lost"]!;
      foundCount.value = count["found"]!;
    } finally {
      isLoading.value = false;
    }
  }
}
