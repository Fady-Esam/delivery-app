class SignUpModel {
  final String userName;
  final String email;
  final String password;
  final String phoneNumber;
  String? image;
  final String roleName;

  SignUpModel({
    required this.userName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.image,
    required this.roleName,
  });
}
