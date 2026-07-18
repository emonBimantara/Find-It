class CreateReportRequest {
  final String title;
  final String description;
  final String location;
  final String category;
  final List<String> imageUrls;
  final DateTime date;
  final String userId;

  CreateReportRequest({
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    required this.imageUrls,
    required this.date,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "location": location,
      "category": category,
      "image_urls": imageUrls,
      "created_at": date.toIso8601String(),
      "user_id": userId,
    };
  }
}
