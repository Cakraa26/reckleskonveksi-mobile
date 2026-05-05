import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils/constants.dart';
import 'utils/app_state.dart';
import 'screens/login_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/dashboard_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const RecklesApp());
}

class RecklesApp extends StatelessWidget {
  const RecklesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      child: MaterialApp(
        title: 'Reckles Konveksi',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.dark(
            primary: AppColors.accent,
            surface: AppColors.secondary,
          ),
          scaffoldBackgroundColor: AppColors.primary,
          useMaterial3: true,
        ),
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
