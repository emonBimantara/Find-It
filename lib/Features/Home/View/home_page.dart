import 'package:findit/Constants/item_categories.dart';
import 'package:findit/Widgets/category_chip.dart';
import 'package:findit/Widgets/custom_text_field.dart';
import 'package:findit/Widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:findit/Features/Home/Controller/home_controller.dart';
import 'package:findit/Features/Auth/Controller/auth_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.find<HomeController>();
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController searchController = TextEditingController();
  String selectedCategory = "all";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            //? App bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => authController.logout(context),
                    child: Icon(Icons.person, size: 30),
                  ),
                  Text(
                    "Find It",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color(0xFF3525CD),
                    ),
                  ),
                  Icon(Icons.notifications, size: 30, color: Color(0xFF3525CD)),
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
                    //? Greeting text
                    Obx(
                      () => Text(
                        "Hello, ${homeController.username.value}!",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "What are you looking for today?",
                      style: TextStyle(fontSize: 15, color: Color(0xFF464555)),
                    ),
                    SizedBox(height: 20),

                    //? Search bar
                    CustomTextField(
                      controller: searchController,
                      hintText: "Search items...",
                      prefixIcon: Icon(Icons.search),
                    ),
                    SizedBox(height: 15),

                    //? Category Slider
                    SizedBox(
                      height: 42,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: itemCategories.length,
                        itemBuilder: (context, index) {
                          final category = itemCategories[index];
                          return CategoryChip(
                            category: category,
                            isSelected: selectedCategory == category.id,
                            onTap: () {
                              setState(() {
                                selectedCategory = category.id;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30),

                    //? Latest Report
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Latest Report",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
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
                    SizedBox(height: 16),

                    Obx(() {
                      if (homeController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (homeController.items.isEmpty) {
                        return const Center(child: Text("No items found"));
                      }

                      final items = homeController.items;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ItemCard(item: items.first, isLarge: true),

                          SizedBox(height: 16),

                          if (items.length > 1)
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: items.length - 1,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 0.77,
                                  ),
                              itemBuilder: (context, index) {
                                return ItemCard(
                                  item: items[index + 1],
                                  isLarge: false,
                                );
                              },
                            ),
                        ],
                      );
                    }),
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
