// Kelas utilitas validasi form - dipakai di Login & Lupa Password
class Validators {
  // Validasi email: tidak kosong + format regex
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Format email tidak valid';
    }
    return null;
  }

  // Validasi password: tidak kosong + min 8 karakter + kombinasi huruf & angka
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password tidak boleh kosong';
    if (value.length < 8) return 'Password minimal 8 karakter';
    if (!RegExp(r'[a-zA-Z]').hasMatch(value))
      return 'Password harus mengandung huruf';
    if (!RegExp(r'[0-9]').hasMatch(value))
      return 'Password harus mengandung angka';
    return null;
  }
}
