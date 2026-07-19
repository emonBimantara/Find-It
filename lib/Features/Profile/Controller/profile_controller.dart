import 'package:findit/Features/Profile/Model/profile_model.dart';
import 'package:findit/Features/Profile/Repository/profile_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final ProfileRepository repository;
  ProfileController(this.repository);

  final isLoading = false.obs;

  final profile = Rxn<ProfileModel>();

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;

      profile.value = await repository.getProfile();
    } finally {
      isLoading.value = false;
    }
  }
}
