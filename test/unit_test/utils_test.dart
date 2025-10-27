import 'package:flutter_test/flutter_test.dart';
import 'package:unit_test_example/utils.dart';

void main() {
  test('Add function should return 2 when adding 1 and 1', () {
    // Arrange
    final a = 1;
    final b = 1;

    // Act
    final result = Utils.add(a, b);

    // Assert
    expect(result, 2);
  });
}
