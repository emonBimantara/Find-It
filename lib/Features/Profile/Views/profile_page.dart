import 'package:findit/Widgets/profile_info_field.dart';
import 'package:findit/Widgets/profile_report_counter.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9FF),
      body: SafeArea(
        child: SingleChildScrollView(
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
                  border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
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
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFEEECFF),
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?q=80&w=150",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: InkWell(
                            onTap: () {},
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
                                    color: Colors.black.withValues(alpha: 0.15),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileInfoField(
                      label: "Username",
                      value: "Shelmond Eugene",
                      onEditTap: () {},
                    ),

                    ProfileInfoField(
                      label: "Email",
                      value: "shelmondeb@gmail.com",
                      onEditTap: () {},
                    ),

                    ProfileInfoField(
                      label: "Phone Number",
                      value: "081234567890",
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

                    ProfileReportCounter(lostCount: 5, foundCount: 3),

                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
