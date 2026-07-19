import 'package:findit/Features/Profile/Controller/profile_controller.dart';
import 'package:findit/Utils/phone_number_helper.dart';
import 'package:findit/Widgets/profile_info_field.dart';
import 'package:findit/Widgets/profile_report_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: Color(0xFFF9F9FF),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.profile.value == null) {
            return Center(child: Text("Profile not found"));
          }

          final profile = controller.profile.value!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                  ),
                  child: Row(
                    children: [
                      BackButton(
                        color: Color(0xFF3525CD),
                        style: IconButton.styleFrom(iconSize: 32),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Color(0xFF3525CD),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 180,
                            height: 180,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFEEECFF),
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              image:
                                  profile.avatarUrl != null &&
                                      profile.avatarUrl!.isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(profile.avatarUrl!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child:
                                profile.avatarUrl == null ||
                                    profile.avatarUrl!.isEmpty
                                ? Icon(
                                    Icons.person,
                                    size: 100,
                                    color: Color(0xFF3525CD),
                                  )
                                : null,
                          ),

                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: InkWell(
                              onTap: () {
                                controller.pickAndUploadAvatar();
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFF3525CD),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.15,
                                      ),
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),

                      Text(
                        "Profile Picture",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF464555),
                          fontSize: 20,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileInfoField(
                        label: "Username",
                        value: profile.username,
                        onEditTap: () {},
                      ),

                      ProfileInfoField(
                        label: "Email",
                        value: profile.email,
                        onEditTap: () {},
                      ),

                      ProfileInfoField(
                        label: "Phone Number",
                        value: PhoneNumberHelper.formatDisplay(
                          profile.phoneNumber,
                        ),
                        onEditTap: () {},
                      ),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Activity Overview",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "View all",
                            style: TextStyle(
                              color: Color(0xFF3525CD),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      ProfileReportCounter(
                        lostCount: controller.lostCount.value,
                        foundCount: controller.foundCount.value,
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
