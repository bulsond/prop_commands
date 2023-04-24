import 'package:prop_commands/prop_commands.dart';
import 'package:test/test.dart';

import '../test_listener.dart';

void main() {
  group('ParameterizedCommand<String>', () {
    const testValue = 'test value';
    late TestListener actionListener;
    late TestListener notifyListener;
    late ParameterizedCommand<String> sut;

    setUp(() {
      actionListener = TestListener();
      notifyListener = TestListener();
      sut = ParameterizedCommand<String>(
        action: (value) => actionListener.invokeSyncWith(value),
        notifyListeners: notifyListener.invokeSync,
      );
    });

    test('''by default, the command is available for calling,
    calls the action method with parameter, and notifies listeners''', () {
      expect(sut.canExecute(), true);
      sut(testValue);
      expect(actionListener.param, testValue);
      expect(actionListener.wasCalled, true);
      expect(notifyListener.wasCalled, true);
    });
    test('''if according to the set conditions, the command cannot be executed,
    then when the command is called,
     an error of the StateError type will be thrown''', () {
      sut = ParameterizedCommand<String>(
        action: (value) => actionListener.invokeSyncWith(value),
        canAction: () => false,
      );
      expect(() => sut(testValue), throwsStateError);
    });
  });
}
