import 'package:unit_test_example/data_source/local_storage/shared_preferences.dart';

class LoginController {
  final SharedPreferences sharedPreferences;

  const LoginController(this.sharedPreferences);

  bool login(String username, String password) {
    final storedUsername = sharedPreferences.getString(username);
    final storedPassword = sharedPreferences.getString(username);
    return password == storedPassword && username == storedUsername;
  }
}
