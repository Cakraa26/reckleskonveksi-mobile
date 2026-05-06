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

  // Factory constructor - mapping email ke profil user
  factory UserModel.fromEmail(String email) {
    if (email == 'admin@reckles.com') {
      return const UserModel(
        name: 'Admin Reckles',
        email: 'admin@reckles.com',
        role: 'Administrator',
        avatarInitial: 'AR',
      );
    }
    return UserModel(
      name: email.split('@').first,
      email: email,
      role: 'Staff',
      avatarInitial: email[0].toUpperCase(),
    );
  }
}
