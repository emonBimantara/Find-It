import 'package:findit/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xFFF9F9FF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.person, size: 30),
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

            SizedBox(height: 40),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF464555),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  CustomTextField(
                    controller: searchController,
                    hintText: "Search items...",
                    prefixIcon: Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
