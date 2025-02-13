class AuthModel {
  final String userId;
  final String userName;
  final String email;
  final String token;
  final String refreshToken;

  AuthModel({
    required this.userId,
    required this.userName,
    required this.email,
    required this.token,
    required this.refreshToken,
  });

  factory AuthModel.fromJson(dynamic json) {
    return AuthModel(
      userId: json["userId"],
      userName: json["userName"],
      email: json["email"],
      token: json["token"],
      refreshToken: json["refreshToken"],
    );
  }
}
