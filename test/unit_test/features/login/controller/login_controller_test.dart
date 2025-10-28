import 'package:flutter/foundation.dart';
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

  group('logout', () {
    test('logout should return true when the clear method returns true',
        () async {
      // Arrange
      final mockSharedPreferences = MockSharedPreferences();
      final loginController = LoginController(mockSharedPreferences);

      // Stubbing
      when(() => mockSharedPreferences.clear())
          .thenAnswer((_) => Future.value(true));

      // Act
      final result = await loginController.logout();

      // Assert
      expect(result, true);
    });

    test('logout should throw an exception when the clear method returns false',
        () async {
      // Arrange
      final mockSharedPreferences = MockSharedPreferences();
      final loginController = LoginController(mockSharedPreferences);

      // Stubbing
      when(() => mockSharedPreferences.clear())
          .thenAnswer((_) => Future.value(false));

      // Act
      final call = loginController.logout;

      // Assert
      expect(call, throwsFlutterError);
    });

    test(
        'logout should throw an exception when the clear method throws an exception',
        () async {
      // Arrange
      final mockSharedPreferences = MockSharedPreferences();
      final loginController = LoginController(mockSharedPreferences);

      // Stubbing
      when(() => mockSharedPreferences.clear())
          .thenThrow(Exception('Logout failed'));

      // Act
      final Future<bool> Function() call = loginController.logout;

      // Assert
      expect(
        call,
        throwsA(isA<FlutterError>()
            .having((e) => e.message, 'error message', 'Logout failed')),
      );
    });
  });
}
