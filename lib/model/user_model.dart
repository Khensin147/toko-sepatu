class UserModel {
  final String id;
  final String? fullName;
  final String? phone;
  final String email;
  final String role;

  UserModel({
    required this.id,
    this.fullName,
    this.phone,
    required this.email,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      fullName: map['full_name'] as String?,
      phone: map['phone'] as String?,
      email: map['email'] ?? '',
      role: map['role'] ?? 'customer',
    );
  }
}
