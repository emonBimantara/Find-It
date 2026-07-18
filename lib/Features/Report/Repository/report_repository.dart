import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:findit/Features/Auth/Repository/supabase_service.dart';
import '../Model/create_report_request.dart';

class ReportRepository {
  Future<List<String>> uploadImages(List<File> images) async {
    final List<String> imageUrls = [];

    for (int i = 0; i < images.length; i++) {
      final image = images[i];

      final fileName =
          "${DateTime.now().millisecondsSinceEpoch}_${i}_${image.path.split('/').last}";

      await SupabaseService.client.storage
          .from("reports")
          .upload(
            fileName,
            image,
            fileOptions: const FileOptions(upsert: true),
          );

      final url = SupabaseService.client.storage
          .from("reports")
          .getPublicUrl(fileName);

      imageUrls.add(url);
    }

    return imageUrls;
  }

  Future<void> createReport(CreateReportRequest request) async {
    await SupabaseService.client.from("items").insert(request.toJson());
  }
}
