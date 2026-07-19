import 'package:findit/Features/Profile/Model/profile_model.dart';
import 'package:findit/Features/Profile/Repository/profile_repository.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

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

  Future<void> pickAndUploadAvatar() async {
    try {
      final picker = ImagePicker();

      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile == null) return;

      final cropped = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      );

      if (cropped == null) return;

      await repository.uploadAvatar(File(cropped.path));

      await loadProfile();
    } catch (e, stackTrace) {
      print("========= AVATAR ERROR =========");
      print(e);
      print(stackTrace);
    }
  }
}
