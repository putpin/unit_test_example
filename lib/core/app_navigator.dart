class Screen {
  final String name;
  final A a;

  Screen(this.name, this.a);
}

class A {
  final String name;
  A(this.name);
}

class AppNavigator {
  void toNamed(String path) {}

  void toScreen(Screen screen) {}

  void showSnackbar(String message) {}
}
