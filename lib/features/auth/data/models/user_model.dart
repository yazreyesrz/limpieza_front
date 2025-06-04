class UserModel {
  final String nombre;
  final String token;

  UserModel({required this.nombre, required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nombre: json['user'] != null ? json['user']['nombre'] ?? '' : '',
      token: json['token'] ?? '',
    );
  }
}
