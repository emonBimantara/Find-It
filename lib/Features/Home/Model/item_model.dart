class ItemModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final String? imageUrl;
  final String location;
  final DateTime createdAt;
  final String? userId;

  ItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.imageUrl,
    required this.location,
    required this.createdAt,
    this.userId,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      category: json["category"],
      imageUrl: json["image_url"],
      location: json["location"],
      createdAt: DateTime.parse(json["created_at"]),
      userId: json["user_id"],
    );
  }
}