import 'package:findit/Features/Home/Model/item_model.dart';
import 'package:findit/Features/ItemDetail/Controller/item_detail_controller.dart';
import 'package:findit/Widgets/custom_button.dart';
import 'package:findit/Widgets/info_card.dart'; // Import custom widget-nya
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class ItemDetailPage extends StatefulWidget {
  final ItemModel item;

  const ItemDetailPage({super.key, required this.item});

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  final PageController _pageController = PageController();
  final ItemDetailController controller = Get.find<ItemDetailController>();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: 350,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: widget.item.imageUrls.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          widget.item.imageUrls[index],
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.broken_image,
                                size: 70,
                                color: Colors.grey,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 16,
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: widget.item.imageUrls.length,
                      effect: WormEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: 8,
                        activeDotColor: Color(0xFF3525CD),
                        dotColor: Colors.white70,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 15,
                    left: 15,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withValues(alpha: 0.9),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => context.pop(),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF4F46E5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          child: Text(
                            widget.item.category.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Text(
                          DateFormat(
                            'dd MMM yyyy',
                          ).format(widget.item.createdAt),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8E8E93),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    Text(
                      widget.item.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 26,
                        height: 1.2,
                        color: Color(0xFF1C1C1E),
                      ),
                    ),

                    SizedBox(height: 25),

                    InfoCard(
                      iconWidget: Image.asset(
                        'assets/location.png',
                        height: 45,
                      ),
                      title: "LOCATION FOUND",
                      subtitle: widget.item.location,
                    ),

                    SizedBox(height: 12),

                    InfoCard(
                      iconWidget: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFF3525CD).withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: Color(0xFF3525CD),
                          size: 25,
                        ),
                      ),
                      title: "REPORTED BY",
                      subtitle: widget.item.username,
                    ),

                    SizedBox(height: 30),

                    Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF1C1C1E),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.item.description,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF6B7280),
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: 30),

                    if (!controller.isMyReport(widget.item.userId)) ...[
                      CustomButton(
                        text: "Contact Reporter",
                        onPressed: () {
                          controller.contactReporter(
                            phoneNumber: widget.item.phoneNumber,
                            username: widget.item.username,
                            itemTitle: widget.item.title,
                          );
                        },
                      ),

                      SizedBox(height: 10),
                    ],
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
