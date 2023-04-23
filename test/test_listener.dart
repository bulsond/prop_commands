class TestListener {
  TestListener();

  bool wasCalled = false;

  void invoke() {
    wasCalled = true;
  }
}
