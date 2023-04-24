class TestListener {
  TestListener();

  bool wasCalled = false;
  String param = '';

  void invokeSync() {
    wasCalled = true;
  }

  void invokeSyncWith(String value) {
    param = value;
    wasCalled = true;
  }

  Future<void> invoke() async {
    await Future.delayed(const Duration(milliseconds: 100));
    wasCalled = true;
  }
}
