// models/user.dart
class User {
  final String email;
  final String? name;
  final String? avatarUrl;

  User({required this.email, this.name, this.avatarUrl});

  String get displayName => name ?? email.split('@').first;
}