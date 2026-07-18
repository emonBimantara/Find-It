import 'dart:io';
import 'package:flutter/material.dart';

class PhotoUpload extends StatelessWidget {
  final List<File> selectedImages;
  final VoidCallback onPickImage;

  const PhotoUpload({
    super.key,
    required this.selectedImages,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: selectedImages.length < 4 ? onPickImage : null,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF3525CD).withValues(alpha: 0.02),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selectedImages.length < 4
                    ? Color(0xFF3525CD).withValues(alpha: 0.2)
                    : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: selectedImages.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFFEBF0FF),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            size: 30,
                            color: Color(0xFF3525CD),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Tap to upload photos",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3525CD),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Selected 0 of 4 photos",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.file(
                              selectedImages[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                selectedImages.length < 4
                                    ? "${selectedImages.length} / 4 Photos"
                                    : "Maximum Reached (4/4)",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),

        SizedBox(height: 16),

        Row(
          children: [
            for (int i = 0; i < 3; i++) ...[
              if (i > 0) SizedBox(width: 12),

              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF3525CD).withValues(alpha: 0.02),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFF3525CD).withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                    ),
                    child: (i + 1) < selectedImages.length
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              selectedImages[i + 1],
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(
                            Icons.image_outlined,
                            color: Color(0xFF3525CD).withValues(alpha: 0.4),
                            size: 26,
                          ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
