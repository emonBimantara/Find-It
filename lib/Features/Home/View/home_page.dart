import 'package:findit/Constants/item_categories.dart';
import 'package:findit/Widgets/category_chip.dart';
import 'package:findit/Widgets/custom_text_field.dart';
import 'package:findit/Widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:findit/Features/Home/Controller/home_controller.dart';
import 'package:findit/Features/Auth/Controller/auth_controller.dart';
import 'package:findit/Features/Auth/View/auth_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = HomeController();
  final AuthController authController = AuthController();

  final TextEditingController searchController = TextEditingController();
  String selectedCategory = "all";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _logout() async {
    try {
      await authController.logout();

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const AuthPage()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
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
                    onTap: _logout,
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
                    Text(
                      "Hello, Emon!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
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

                    FutureBuilder(
                      future: homeController.getItems(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Text("No items found");
                        }

                        final items = snapshot.data!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (items.isNotEmpty) ...[
                              ItemCard(item: items[0], isLarge: true),
                              const SizedBox(height: 16),

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
                                    final item = items[index + 1];
                                    return ItemCard(item: item, isLarge: false);
                                  },
                                ),
                            ],
                          ],
                        );
                      },
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
