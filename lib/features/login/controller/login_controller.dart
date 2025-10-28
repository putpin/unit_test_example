import 'package:flutter/foundation.dart';
import 'package:unit_test_example/data_source/local_storage/shared_preferences.dart';

class LoginController {
  final SharedPreferences _sharedPreferences;

  const LoginController(this._sharedPreferences);

  bool login(String username, String password) {
    final storedUsername =
        _sharedPreferences.getString(SharedPreferences.usernameKey);
    final storedPassword =
        _sharedPreferences.getString(SharedPreferences.passwordKey);
    return password == storedPassword && username == storedUsername;
  }

  Future<bool> logout() async {
    bool success = false;
    try {
      success = await _sharedPreferences.clear();
    } catch (e) {
      success = false;
    }

    if (!success) {
      throw FlutterError('Logout failed');
    }

    return success;
  }

  void close() {
    // Close resources if needed
  }
}
