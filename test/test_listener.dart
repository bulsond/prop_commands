class TestListener {
  TestListener();

  bool wasCalled = false;

  void notifyListeners() {
    wasCalled = true;
  }
}
