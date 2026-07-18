import 'package:findit/Constants/item_categories.dart';
import 'package:findit/Features/Auth/Controller/auth_controller.dart';
import 'package:findit/Features/Home/Controller/home_controller.dart';
import 'package:findit/Routes/app_routes.dart';
import 'package:findit/Widgets/category_chip.dart';
import 'package:findit/Widgets/custom_text_field.dart';
import 'package:findit/Widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

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
                    SizedBox(height: 20),
                    Obx(
                      () => Text(
                        "Hello, ${homeController.username.value}!",
                        style: TextStyle(
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

                    CustomTextField(
                      controller: homeController.searchController,
                      hintText: "Search items...",
                      prefixIcon: const Icon(Icons.search),
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
                              isSelected:
                                  homeController.selectedCategory.value ==
                                  category.id,
                              onTap: () {
                                homeController.changeCategory(category.id);
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 30),

                    Obx(() {
                      final isSearching =
                          homeController.searchQuery.value.isNotEmpty;
                      final items = isSearching
                          ? homeController.filteredItems
                          : homeController.recentItems;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isSearching
                                    ? "Search Results (${items.length})"
                                    : "Latest Report",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              if (!isSearching)
                                GestureDetector(
                                  onTap: () =>
                                      context.push(AppRoutes.viewAllPage),
                                  child: Text(
                                    "View all",
                                    style: TextStyle(
                                      color: Color(0xFF3525CD),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          SizedBox(height: 16),

                          if (homeController.isLoading.value) ...[
                            const Center(child: CircularProgressIndicator()),
                          ] else if (items.isEmpty) ...[
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  "No items found",
                                  style: TextStyle(color: Color(0xFF464555)),
                                ),
                              ),
                            ),
                          ] else if (isSearching) ...[
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: items.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
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
                            ),
                          ] else ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ItemCard(item: items.first, isLarge: true),
                                const SizedBox(height: 16),
                                if (items.length > 1)
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                            ),
                          ],
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

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF3525CD),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () => context.push(AppRoutes.reportPage),
        child: Icon(Icons.add, size: 28),
      ),
    );
  }
}
