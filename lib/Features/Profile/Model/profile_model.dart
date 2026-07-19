class ProfileModel {
  final String id;
  final String username;
  final String email;
  final String phoneNumber;
  final String? avatarUrl;

  ProfileModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.avatarUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json, String email) {
    return ProfileModel(
      id: json["id"],
      username: json["username"] ?? "",
      phoneNumber: json["phone_number"] ?? "",
      avatarUrl: json["avatar_url"],
      email: email,
    );
  }
}
