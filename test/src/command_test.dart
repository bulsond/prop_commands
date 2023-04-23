import 'package:prop_commands/prop_commands.dart';
import 'package:test/test.dart';

import '../test_listener.dart';

void main() {
  group('Command', () {
    late TestListener actionListener;
    late TestListener notifyListener;
    late Command sut;

    setUp(() {
      actionListener = TestListener();
      notifyListener = TestListener();
      sut = Command(
        action: actionListener.invoke,
        notifyListeners: notifyListener.invoke,
      );
    });

    test('''by default, the command is available for calling,
    calls the action method, and notifies listeners''', () {
      expect(sut.canExecute(), true);
      sut();
      expect(actionListener.wasCalled, true);
      expect(notifyListener.wasCalled, true);
    });
    test('''if according to the set conditions, the command cannot be executed,
    then when the command is called,
     an error of the StateError type will be thrown''', () {
      sut = Command(
        action: actionListener.invoke,
        canAction: () => false,
      );
      expect(() => sut(), throwsStateError);
    });
  });
}
