import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unit_test_example/data_source/local_storage/shared_preferences.dart';
import 'package:unit_test_example/features/login/controller/login_controller.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  test('LoginController login should return true for correct credentials', () {
    // Arrange
    final mockSharedPreferences = MockSharedPreferences();
    const username = 'cuongpv';
    const password = '123456';

    when(() => mockSharedPreferences.getString(SharedPreferences.usernameKey))
        .thenReturn(username);
    when(() => mockSharedPreferences.getString(SharedPreferences.passwordKey))
        .thenReturn(password);

    final loginController = LoginController(mockSharedPreferences);

    // Act
    final result = loginController.login(username, password);

    // Assert
    expect(result, isTrue);
  });
}
