import 'package:findit/Features/Report/Controller/report_controller.dart';
import 'package:findit/Widgets/custom_button.dart';
import 'package:findit/Widgets/custom_text_field.dart';
import 'package:findit/Widgets/custom_toggle_switch.dart';
import 'package:findit/Widgets/photo_upload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportPage extends StatelessWidget {
  ReportPage({super.key});

  final ReportController reportController = Get.find<ReportController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9FF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(),
                  Text(
                    "Create Report",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color(0xFF3525CD),
                    ),
                  ),
                  SizedBox(width: 48),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Report an Item",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 5),

                    Obx(
                      () => Text(
                        reportController.isFoundSelected.value
                            ? "Provide details to help return it to its owner."
                            : "Provide details to help others identify and find your item.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF464555),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    Obx(
                      () => CustomToggleSwitch(
                        leftText: "I Found This",
                        rightText: "I Lost This",
                        isLeftSelected: reportController.isFoundSelected.value,
                        onToggle: (value) {
                          reportController.isFoundSelected.value = value;
                        },
                      ),
                    ),

                    SizedBox(height: 30),
                    Text(
                      "PHOTOS (UP TO 4)",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF464555),
                      ),
                    ),
                    SizedBox(height: 12),

                    Obx(
                      () => PhotoUpload(
                        selectedImages: reportController.selectedImages
                            .toList(),
                        onPickImage: reportController.pickImageFromGallery,
                      ),
                    ),

                    SizedBox(height: 30),

                    Text(
                      "TITLE",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF464555),
                      ),
                    ),

                    SizedBox(height: 12),

                    CustomTextField(
                      controller: reportController.titleController,
                      hintText: "Ex: Black Wallet",
                    ),

                    SizedBox(height: 20),

                    Text(
                      "DESCRIPTION",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF464555),
                      ),
                    ),

                    SizedBox(height: 12),

                    CustomTextField(
                      controller: reportController.descriptionController,
                      hintText: "Describe the item...",
                      maxLines: 5,
                    ),

                    SizedBox(height: 20),

                    Text(
                      "LOCATION",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF464555),
                      ),
                    ),

                    SizedBox(height: 12),

                    CustomTextField(
                      controller: reportController.locationController,
                      hintText: "Ex: Library Building A",
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),

                    SizedBox(height: 20),

                    Text(
                      "DATE",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF464555),
                      ),
                    ),

                    SizedBox(height: 12),

                    CustomTextField(
                      controller: reportController.dateController,
                      hintText: "Select report date",
                      readOnly: true,
                      prefixIcon: Icon(Icons.calendar_today_outlined),
                      onTap: () => reportController.pickDate(context),
                    ),

                    SizedBox(height: 30),

                    Obx(
                      () => CustomButton(
                        text: reportController.isLoading.value
                            ? "Publishing..."
                            : "Publish Report",
                        onPressed: () => reportController.publishReport(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
