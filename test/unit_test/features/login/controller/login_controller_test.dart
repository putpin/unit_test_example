import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unit_test_example/core/app_navigator.dart';
import 'package:unit_test_example/data_source/local_storage/shared_preferences.dart';
import 'package:unit_test_example/features/login/controller/login_controller.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class FakeSharedPreferences extends Fake implements SharedPreferences {
  @override
  String? getString(String key) {
    return 'pvc';
  }

  @override
  void setString(String key, String value) {}

  @override
  Future<bool> clear() async {
    return true;
  }
}

class MockAppNavigator extends Mock implements AppNavigator {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late AppNavigator mockAppNavigator;
  late LoginController loginController;

  setUpAll(() {
    registerFallbackValue(Screen('home'));
  });

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    mockAppNavigator = MockAppNavigator();
    loginController = LoginController(mockSharedPreferences, mockAppNavigator);
  });

  tearDown(() {
    loginController.close();
  });

  group('login', () {
    test('LoginController login should return true for correct credentials',
        () {
      // Arrange
      const username = 'cuongpv';
      const password = '123456';

      when(() => mockSharedPreferences.getString(SharedPreferences.usernameKey))
          .thenReturn(username);
      when(() => mockSharedPreferences.getString(SharedPreferences.passwordKey))
          .thenReturn(password);

      // Act
      final result = loginController.login(username, password);

      // Assert
      expect(result, isTrue);
    });
  });

  group('login2', () {
    test('navigate to home on successful login2', () {
      // Arrange
      const username = 'cuongpv';
      const password = '123456';

      when(() => mockSharedPreferences.getString(SharedPreferences.usernameKey))
          .thenReturn(username);
      when(() => mockSharedPreferences.getString(SharedPreferences.passwordKey))
          .thenReturn(password);
      // Act
      loginController.login2(username, password);
      // Assert
      verify(() => mockAppNavigator.toNamed('/home')).called(1);
      // verify(() => mockAppNavigator.toNamed(any())).called(1);
    });

    test('show snackbar on failed login2', () {
      // Arrange
      const username = 'cuongpv';
      const password = 'wrong_password';
      when(() => mockSharedPreferences.getString(SharedPreferences.usernameKey))
          .thenReturn(username);
      when(() => mockSharedPreferences.getString(SharedPreferences.passwordKey))
          .thenReturn('123456');
      // Act
      loginController.login2(username, password);
      // Assert
      verify(() => mockAppNavigator.showSnackbar('Login failed')).called(1);
    });
  });

  group('login2', () {});

  group('logout', () {
    test('logout should return true when the clear method returns true',
        () async {
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

  test('Goto home screen', () {
    // Act
    loginController.gotoHomeScreen();

    // Assert
    verify(() => mockAppNavigator.toScreen(any())).called(1);
  });
}
