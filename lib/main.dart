import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils/constants.dart';
import 'utils/app_state.dart';
import 'screens/login_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/dashboard_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Status bar transparan agar menyatu dengan background light
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, // icon gelap untuk light theme
    ),
  );
  runApp(const RecklesApp());
}

class RecklesApp extends StatelessWidget {
  const RecklesApp({super.key});

  @override
  Widget build(BuildContext context) {
    // AppStateWrapper membungkus MaterialApp agar InheritedWidget mencakup semua route
    return AppStateWrapper(
      child: MaterialApp(
        title: 'Reckles Konveksi',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: AppColors.accent,
            surface: AppColors.primary,
          ),
          scaffoldBackgroundColor: AppColors.primary,
          useMaterial3: true,
        ),
        // 3 named routes wajib terdaftar di sini
        initialRoute: AppRoutes.login,
        routes: {
          AppRoutes.login: (_) => const LoginScreen(),
          AppRoutes.forgotPassword: (_) => const ForgotPasswordScreen(),
          AppRoutes.dashboard: (_) => const DashboardScreen(),
        },
      ),
    );
  }
}
