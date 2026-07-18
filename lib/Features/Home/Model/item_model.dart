class ItemModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final List<String> imageUrls;
  final String location;
  final DateTime createdAt;
  final String? userId;
  final String username;
  final String phoneNumber;

  ItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrls,
    required this.location,
    required this.createdAt,
    this.userId,
    required this.username,
    required this.phoneNumber,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      category: json["category"],
      imageUrls: List<String>.from(json["image_urls"] ?? []),
      location: json["location"],
      createdAt: DateTime.parse(json["created_at"]),
      userId: json["user_id"],
      username: json["profiles"]?["username"] ?? "Unknown User",
      phoneNumber: json["profiles"]?["phone_number"] ?? "",
    );
  }
}
