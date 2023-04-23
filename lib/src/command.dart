/// [Command] is a class for creating wrappers for methods in objects
/// that extend [ChangeNotifier].
/// [action] - a reference to the method to be executed when calling the command,
/// [canAction] - a reference to a method that defines the conditions
/// for the executability of the command, if execution is possible,
/// it should return true, [notifyListeners] - a reference to the method
/// of the same name in [ChangeNotifier].
class Command {
  Command({
    required void Function() action,
    bool Function()? canAction,
    void Function()? notifyListeners,
  })  : _action = action,
        _canAction = canAction ?? (() => true),
        _notifyListeners = notifyListeners ?? (() {});

  final void Function() _action;
  final bool Function() _canAction;
  final void Function() _notifyListeners;

  void execute() {
    if (_canAction() == false) {
      throw StateError('''The constraints in the _canAction() method
             do not allow the command to be executed.''');
    }
    _action();
    _notifyListeners();
  }

  void call() => execute();

  bool canExecute() => _canAction();
}
