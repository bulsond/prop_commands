/// [AsyncCommand] is a class for creating wrappers for asynchronous methods
/// in objects that extend [ChangeNotifier].
/// [action] - a reference to the asynchronous method to be executed
/// when calling the command, [canAction] - a reference to a method
/// that defines the conditions for the executability of the command,
/// if execution is possible, it should return true,
/// [notifyListeners] - a reference to the method
/// of the same name in [ChangeNotifier].
class AsyncCommand {
  AsyncCommand({
    required Future<void> Function() action,
    bool Function()? canAction,
    void Function()? notifyListeners,
  })  : _action = action,
        _canAction = canAction ?? (() => true),
        _notifyListeners = notifyListeners ?? (() {});

  final Future<void> Function() _action;
  final bool Function() _canAction;
  final void Function() _notifyListeners;

  Future<void> execute() async {
    if (_canAction() == false) {
      throw StateError('''The constraints in the _canAction() method
             do not allow the command to be executed.''');
    }
    await _action();
    _notifyListeners();
  }

  Future<void> call() async => await execute();

  bool canExecute() => _canAction();
}
