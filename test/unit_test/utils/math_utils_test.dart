import 'package:flutter_test/flutter_test.dart';
import 'package:unit_test_example/utils/math_utils.dart';

void main() {
  test('Add function should return 2 when adding 1 and 1', () {
    // Arrange
    final a = 1;
    final b = 1;

    // Act
    final result = MathUtils.add(a, b);

    // Assert
    expect(result, 2);
  });

  group('Test isEven function', () {
    test('isEven should return true for even number', () {
      expect(MathUtils.isEven(2), true);
    });

    test('isEven should return false for odd number', () {
      expect(MathUtils.isEven(3), false);
    });

    test('isEven should return true for zero', () {
      expect(MathUtils.isEven(0), true); // Matcher isTrue
    });

    test('isEven should return true for negative even number', () {
      expect(MathUtils.isEven(-4), isTrue); // Matcher isTrue
    });

    test('isEven should return false for negative odd number', () {
      expect(MathUtils.isEven(-5), isFalse); // Matcher isFalse
    });
  });
}
