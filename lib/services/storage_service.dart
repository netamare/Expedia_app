import 'dart:async';

class StorageService {
  // Fake in-memory storage for demo
  final Map<String, String> _store = {};

  Future<void> write(String key, String value) async {
    await Future.delayed(Duration(milliseconds: 150));
    _store[key] = value;
  }

  Future<String?> read(String key) async {
    await Future.delayed(Duration(milliseconds: 100));
    return _store[key];
  }

  Future<void> delete(String key) async {
    await Future.delayed(Duration(milliseconds: 80));
    _store.remove(key);
  }
}