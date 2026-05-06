import 'package:flutter/material.dart';
import '../models/user_model.dart';

// InheritedWidget - menyebarkan state user ke seluruh widget tree
class AppState extends InheritedWidget {
  final UserModel? currentUser;
  final void Function(UserModel?) setUser;

  const AppState({
    super.key,
    required this.currentUser,
    required this.setUser,
    required super.child,
  });

  // Akses AppState dari context manapun di bawah tree
  static AppState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>();
  }

  // Rebuild widget yang bergantung hanya jika currentUser berubah
  @override
  bool updateShouldNotify(AppState oldWidget) {
    return oldWidget.currentUser != currentUser;
  }
}

// StatefulWidget pembungkus yang menyimpan state sebenarnya
class AppStateWrapper extends StatefulWidget {
  final Widget child;
  const AppStateWrapper({super.key, required this.child});

  @override
  State<AppStateWrapper> createState() => _AppStateWrapperState();
}

class _AppStateWrapperState extends State<AppStateWrapper> {
  UserModel? _currentUser; // state global: data user yang sedang login

  // Fungsi setter - dipanggil saat login berhasil atau logout
  void _setUser(UserModel? user) {
    setState(() => _currentUser = user);
  }

  @override
  Widget build(BuildContext context) {
    return AppState(
      currentUser: _currentUser,
      setUser: _setUser,
      child: widget.child,
    );
  }
}
