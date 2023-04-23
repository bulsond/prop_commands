class TestListener {
  TestListener();

  bool wasCalled = false;

  void invokeSync() {
    wasCalled = true;
  }

  Future<void> invoke() async {
    await Future.delayed(const Duration(milliseconds: 100));
    wasCalled = true;
  }
}
