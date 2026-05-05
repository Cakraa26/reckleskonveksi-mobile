// lib/utils/app_state.dart

import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AppState extends InheritedWidget {
  final UserModel? currentUser;
  final void Function(UserModel?) setUser;

  const AppState({
    super.key,
    required this.currentUser,
    required this.setUser,
    required super.child,
  });

  static AppState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>();
  }

  @override
  bool updateShouldNotify(AppState oldWidget) {
    return oldWidget.currentUser != currentUser;
  }
}

class AppStateWrapper extends StatefulWidget {
  final Widget child;

  const AppStateWrapper({super.key, required this.child});

  @override
  State<AppStateWrapper> createState() => _AppStateWrapperState();
}

class _AppStateWrapperState extends State<AppStateWrapper> {
  UserModel? _currentUser;

  void _setUser(UserModel? user) {
    setState(() {
      _currentUser = user;
    });
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
