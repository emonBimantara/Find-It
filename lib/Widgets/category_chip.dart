import 'package:findit/Constants/item_categories.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final ItemCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF3525CD).withValues(alpha: 0.1)
                : const Color(0xFFDCE2F7),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              category.name,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF3525CD)
                    : const Color(0xFF6B7280),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
