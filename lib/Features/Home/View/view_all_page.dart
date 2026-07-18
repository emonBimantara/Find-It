import 'package:findit/Constants/item_categories.dart';
import 'package:findit/Features/Auth/Controller/auth_controller.dart';
import 'package:findit/Features/Home/Controller/home_controller.dart';
import 'package:findit/Widgets/category_chip.dart';
import 'package:findit/Widgets/custom_text_field.dart';
import 'package:findit/Widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAllPage extends StatelessWidget {
  ViewAllPage({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final AuthController authController = Get.find<AuthController>();

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
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => authController.logout(context),
                    child: const Icon(Icons.person, size: 30),
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

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "All Reported Items",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 15),

                  CustomTextField(
                    controller: homeController.searchController,
                    hintText: "Search items...",
                    prefixIcon: Icon(Icons.search),
                  ),
                  SizedBox(height: 15),

                  SizedBox(
                    height: 42,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: itemCategories.length,
                      itemBuilder: (context, index) {
                        final category = itemCategories[index];

                        return Obx(
                          () => CategoryChip(
                            category: category,
                            isSelected: homeController.selectedCategory.value == category.id,
                            onTap: () {
                              homeController.changeCategory(category.id);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Expanded(
              child: Obx(() {
                if (homeController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                final items = homeController.filteredItems;

                if (items.isEmpty) {
                  return const Center(
                    child: Text(
                      "No items found matching your criteria",
                      style: TextStyle(color: Color(0xFF464555), fontSize: 15),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.77,
                  ),
                  itemBuilder: (context, index) {
                    return ItemCard(
                      item: items[index],
                      isLarge: false,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}