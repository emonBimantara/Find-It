import 'package:findit/Features/Home/Model/item_model.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;
  final bool isLarge;

  const ItemCard({super.key, required this.item, this.isLarge = false});

  @override
  Widget build(BuildContext context) {
    final bool isLost = item.category.toLowerCase() == "lost";

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: item.imageUrls.isNotEmpty
                    ? Image.network(
                        item.imageUrls.first,
                        height: isLarge ? 180 : 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            height: isLarge ? 180 : 120,
                            width: double.infinity,
                            color: Color(0xFFEBF0FF),
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                            ),
                          );
                        },
                      )
                    : Container(
                        height: isLarge ? 180 : 120,
                        width: double.infinity,
                        color: Color(0xFFEBF0FF),
                        child: Icon(Icons.image, color: Colors.grey),
                      ),
              ),

              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isLost) ...[
                        Icon(Icons.error_outline, color: Colors.red, size: 14),
                        SizedBox(width: 4),
                      ],

                      Text(
                        isLost ? "LOST" : "FOUND",
                        style: TextStyle(
                          color: isLost ? Colors.red : Color(0xFF3B3DBF),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: isLarge ? 20 : 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 6),

                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4),

                    Expanded(
                      child: Text(
                        item.location,
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6),

                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey),
                    SizedBox(width: 4),

                    Expanded(
                      child: Text(
                        "${item.createdAt.day}/${item.createdAt.month}/${item.createdAt.year}",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
