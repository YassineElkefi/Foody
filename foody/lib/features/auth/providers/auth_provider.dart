import 'package:flutter/material.dart';
import 'package:foody/core/services/auth_service.dart';
import 'package:foody/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService authService;
  User? _user;
  String? _token;

  AuthProvider({required this.authService}) {
    _loadUserFromPrefs();
  }

  User? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isAdmin => user?.role == 'ROLE_ADMIN';
  String? get token => _token;

  Future<User?> login(String email, String password) async {
    _user = await authService.login(email, password);
    if (_user != null) {
      _token = _user!.token;
      await _saveUserToPrefs(_user!);
    }
    notifyListeners();
    return _user;
  }

  Future<void> register(String username, String email, String password) async {
    _user = await authService.register(username, email, password);
    if (_user != null) {
      _token = _user!.token;
      await _saveUserToPrefs(_user!);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    _user = null;
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    notifyListeners();
  }

  Future<void> _saveUserToPrefs(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user.toJson());
  }

  Future<void> _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      _user = User.fromJsonString(userJson);
      _token = _user!.token;
      notifyListeners();
    }
  }
}