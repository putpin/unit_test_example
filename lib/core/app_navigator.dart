class Screen {
  final String name;

  Screen(this.name);
}

class AppNavigator {
  void toNamed(String path) {}

  void toScreen(Screen screen) {}

  void showSnackbar(String message) {}
}
