import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import '../utils/app_state.dart';
import '../models/user_model.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  // GlobalKey untuk mengakses state Form (validate, save, reset)
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // State lokal: dikelola dengan setState
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  String? _errorMessage;

  // Animasi fade+slide saat halaman pertama dibuka
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    // Wajib dispose controller agar tidak memory leak
    _emailController.dispose();
    _passwordController.dispose();
    _animController.dispose();
    super.dispose();
  }

  // Handler tombol login - async karena simulasi network delay
  Future<void> _handleLogin() async {
    // Validasi semua field dalam Form sekaligus
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulasi delay network request
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Pengecekan kredensial hardcoded (mock authentication)
    final isValid =
        (email == AppCredentials.email &&
            password == AppCredentials.password) ||
        (email == AppCredentials.staffEmail &&
            password == AppCredentials.staffPassword);

    if (isValid) {
      // Set user ke InheritedWidget agar bisa diakses di semua halaman
      AppState.of(context)?.setUser(UserModel.fromEmail(email));
      ScaffoldMessenger.of(context).showSnackBar(
        _buildSnackBar(
          'Login berhasil! Selamat datang.',
          AppColors.success,
          Icons.check_circle_outline,
        ),
      );
      // Ganti halaman login dengan dashboard - tidak bisa back
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Email atau password salah.';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        _buildSnackBar(
          _errorMessage!,
          Colors.red.shade700,
          Icons.error_outline,
        ),
      );
    }
  }

  // Helper builder SnackBar agar konsisten
  SnackBar _buildSnackBar(String msg, Color bg, IconData icon) {
    return SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white, size: 17),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              msg,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
      backgroundColor: bg,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48),

                  // ── HEADER: logo + brand ──
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.content_cut,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'RECKLES',
                            style: GoogleFonts.barlow(
                              color: AppColors.textPrimary,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 3,
                            ),
                          ),
                          Text(
                            'KONVEKSI',
                            style: GoogleFonts.barlow(
                              color: AppColors.accent,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 4,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 44),
                  Text(
                    'Selamat Datang\nKembali 👋',
                    style: GoogleFonts.barlow(
                      color: AppColors.textPrimary,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Masuk untuk mengelola pesanan konveksi Anda',
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // ── INFO DEMO KREDENSIAL ──
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.accent.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.accent,
                          size: 17,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'admin@reckles.com  /  Admin123',
                          style: GoogleFonts.sourceCodePro(
                            color: AppColors.accent,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── FORM LOGIN: menggunakan GlobalKey<FormState> ──
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          label: 'EMAIL',
                          hint: 'email@reckles.com',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.validateEmail,
                        ),
                        const SizedBox(height: 18),
                        // Password field dengan toggle visibility
                        CustomTextField(
                          controller: _passwordController,
                          label: 'PASSWORD',
                          hint: 'Minimal 8 karakter',
                          prefixIcon: Icons.lock_outline,
                          obscureText: !_isPasswordVisible,
                          validator: Validators.validatePassword,
                          suffixWidget: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.textHint,
                              size: 20,
                            ),
                            // setState untuk state isPasswordVisible
                            onPressed: () => setState(
                              () => _isPasswordVisible = !_isPasswordVisible,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ── ERROR MESSAGE dari state _errorMessage ──
                  if (_errorMessage != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 9,
                      ),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.red.shade600,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _errorMessage!,
                            style: GoogleFonts.inter(
                              color: Colors.red.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // ── LINK LUPA PASSWORD → Navigator.pushNamed ──
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        AppRoutes.forgotPassword,
                      ),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        'Lupa Password?',
                        style: GoogleFonts.inter(
                          color: AppColors.accent,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── TOMBOL LOGIN dengan loading indicator ──
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        disabledBackgroundColor: AppColors.accent.withValues(
                          alpha: 0.5,
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      // Tampilkan CircularProgressIndicator saat isLoading == true
                      child: _isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : Text(
                              'MASUK',
                              style: GoogleFonts.barlow(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Footer
                  Center(
                    child: Text(
                      '© 2025 Reckles Konveksi',
                      style: GoogleFonts.inter(
                        color: AppColors.textHint,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
