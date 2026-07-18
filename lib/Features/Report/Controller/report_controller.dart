import 'dart:io';

import 'package:findit/Features/Auth/Repository/supabase_service.dart';
import 'package:findit/Features/Home/Controller/home_controller.dart';
import 'package:findit/Features/Report/Model/create_report_request.dart';
import 'package:findit/Features/Report/Repository/report_repository.dart';
import 'package:findit/Utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ReportController extends GetxController {
  final ReportRepository _repository;

  ReportController(this._repository);

  final isFoundSelected = true.obs;
  final selectedImages = <File>[].obs;
  final isLoading = false.obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final dateController = TextEditingController();

  DateTime? selectedDate;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    if (selectedImages.length >= 4) return;

    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      selectedImages.add(File(pickedFile.path));
    }
  }

  Future<void> pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      selectedDate = pickedDate;

      dateController.text = DateFormat("dd MMM yyyy").format(pickedDate);
    }
  }

  Future<void> publishReport(BuildContext context) async {
    try {
      isLoading.value = true;

      if (titleController.text.trim().isEmpty) {
        throw Exception("Title is required");
      }

      if (descriptionController.text.trim().isEmpty) {
        throw Exception("Description is required");
      }

      if (locationController.text.trim().isEmpty) {
        throw Exception("Location is required");
      }

      if (selectedDate == null) {
        throw Exception("Date is required");
      }

      if (selectedImages.isEmpty) {
        throw Exception("Please upload at least one photo");
      }

      final user = SupabaseService.client.auth.currentUser;

      if (user == null) {
        throw Exception("Please login again.");
      }

      final imageUrls = await _repository.uploadImages(selectedImages);

      final request = CreateReportRequest(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        location: locationController.text.trim(),
        category: isFoundSelected.value ? "found" : "lost",
        imageUrls: imageUrls,
        date: selectedDate!,
        userId: user.id,
      );

      await _repository.createReport(request);

      SnackbarHelper.success(context, "Report published!");

      clearForm();

      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().fetchItems();
      }

      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/homePage');
      }
    } catch (e) {
      SnackbarHelper.error(
        context,
        e.toString().replaceFirst("Exception: ", ""),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    locationController.clear();
    dateController.clear();

    selectedImages.clear();

    selectedDate = null;
    isFoundSelected.value = true;
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    dateController.dispose();

    super.onClose();
  }
}
