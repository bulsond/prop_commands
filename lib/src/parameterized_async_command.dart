/// [ParameterizedAsyncCommand<T>] is a class for creating wrappers
/// for asynchronous methods with parameter
/// in objects that extend [ChangeNotifier].
/// [action] - a reference to the method to be executed when calling the command,
/// [canAction] - a reference to a method that defines the conditions
/// for the executability of the command, if execution is possible,
/// it should return true, [notifyListeners] - a reference to the method
/// of the same name in [ChangeNotifier].
class ParameterizedAsyncCommand<T> {
  ParameterizedAsyncCommand({
    required Future<void> Function(T param) action,
    bool Function()? canAction,
    void Function()? notifyListeners,
  })  : _action = action,
        _canAction = canAction ?? (() => true),
        _notifyListeners = notifyListeners ?? (() {});

  final Future<void> Function(T param) _action;
  final bool Function() _canAction;
  final void Function() _notifyListeners;

  /// Calling the method defined as [action].
  /// [param] - command call parameter.
  /// The call may result in an error of the type [StateError].
  Future<void> execute(T param) async {
    if (_canAction() == false) {
      throw StateError('''The constraints in the _canAction() method
             do not allow the command to be executed.''');
    }
    await _action(param);
    _notifyListeners();
  }

  /// An additional way to call the method defined as [action].
  /// [param] - command call parameter.
  Future<void> call(T param) async => await execute(param);

  /// Invoking the validation method to determine
  /// whether a command can be called.
  /// Returns true if the command can be called.
  bool canExecute() => _canAction();
}
