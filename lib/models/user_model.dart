class UserModel {
  final String id;
  final String name;
  final String imgPath;
  final String phone;
  bool? isOnline;

  UserModel({
    required this.id,
    required this.name,
    required this.imgPath,
    required this.phone,
    this.isOnline,
  });
}
