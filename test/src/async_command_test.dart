import 'package:prop_commands/prop_commands.dart';
import 'package:test/test.dart';

import '../test_listener.dart';

void main() {
  group('AsyncCommand', () {
    late TestListener actionListener;
    late TestListener notifyListener;
    late AsyncCommand sut;

    setUp(() {
      actionListener = TestListener();
      notifyListener = TestListener();
      sut = AsyncCommand(
        action: actionListener.invoke,
        notifyListeners: notifyListener.invokeSync,
      );
    });

    test('''by default, the command is available for calling,
    calls the action method, and notifies listeners''', () async {
      expect(sut.canExecute(), true);
      await sut();
      expect(actionListener.wasCalled, true);
      expect(notifyListener.wasCalled, true);
    });
    test('''if according to the set conditions, the command cannot be executed,
    then when the command is called,
     an error of the StateError type will be thrown''', () {
      sut = AsyncCommand(
        action: actionListener.invoke,
        canAction: () => false,
      );
      expect(() async => await sut(), throwsStateError);
    });
  });
}
