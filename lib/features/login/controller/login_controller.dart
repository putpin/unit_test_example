import 'package:flutter/foundation.dart';
import 'package:unit_test_example/core/app_navigator.dart';
import 'package:unit_test_example/data_source/local_storage/shared_preferences.dart';

class LoginController {
  final SharedPreferences _sharedPreferences;
  final AppNavigator _appNavigator;

  const LoginController(
    this._sharedPreferences,
    this._appNavigator,
  );

  bool login(String username, String password) {
    final storedUsername =
        _sharedPreferences.getString(SharedPreferences.usernameKey);
    final storedPassword =
        _sharedPreferences.getString(SharedPreferences.passwordKey);
    return password == storedPassword && username == storedUsername;
  }

  void login2(String username, String password) {
    final storedUsername =
        _sharedPreferences.getString(SharedPreferences.usernameKey);
    final storedPassword =
        _sharedPreferences.getString(SharedPreferences.passwordKey);
    final success = password == storedPassword && username == storedUsername;

    if (success) {
      _appNavigator.toNamed('/home');
    } else {
      _appNavigator.showSnackbar('Login failed');
    }
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
