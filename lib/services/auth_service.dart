import 'dart:async';
import '../models/user.dart';

class AuthService {
  User? _currentUser;

  Future<User> login({required String email, required String password}) async {
    await Future.delayed(Duration(milliseconds: 700)); // fake latency
    // Very simple fake auth
    _currentUser = User(
      id: 'u1',
      name: 'Demo User',
      email: email,
      avatarUrl: null,
    );
    return _currentUser!;
  }

  Future<User> signup({required String name, required String email, required String password}) async {
    await Future.delayed(Duration(milliseconds: 900));
    _currentUser = User(id: 'u2', name: name, email: email, avatarUrl: null);
    return _currentUser!;
  }

  Future<void> logout() async {
    await Future.delayed(Duration(milliseconds: 300));
    _currentUser = null;
  }

  User? get currentUser => _currentUser;
}