// Model data user yang sedang login
class UserModel {
  final String name;
  final String email;
  final String role;
  final String avatarInitial; // inisial untuk avatar lingkaran

  const UserModel({
    required this.name,
    required this.email,
    required this.role,
    required this.avatarInitial,
  });

 // Factory constructor untuk membuat data admin
  factory UserModel.fromEmail(String email) {
    return const UserModel(
      name: 'Admin Reckles',
      email: 'admin@reckles.com',
      role: 'Administrator',
      avatarInitial: 'AR',
    );
  }
}
