/// [Property<T>] is a class for creating properties in objects
/// that extend [ChangeNotifier].
/// [initialValue] - the original value of the property,
/// [notifyListeners] - a reference to the method
/// of the same name in [ChangeNotifier],
/// [verificationRules] - a reference to the verification rules
/// for the value of this property. The rules are a map, where the key
/// is a string value containing information about the error, and
/// the value is a method that checks the value of the property and
/// returns true if the value of the property causes this error.
class Property<T> {
  Property({
    required T initialValue,
    void Function()? notifyListeners,
    Map<String, bool Function(T value)>? verificationRules,
  })  : _value = initialValue,
        _notifyListeners = notifyListeners ?? (() {}),
        _verificationRules = verificationRules ?? {} {
    if (_verificationRules.isNotEmpty) {
      _verifyValue();
    }
  }

  final void Function() _notifyListeners;
  final Map<String, bool Function(T value)> _verificationRules;

  final List<String> _errors = [];
  List<String> get errors => List.unmodifiable(_errors);
  bool get hasErrors =>
      _verificationRules.entries.any((rule) => rule.value(_value));

  late T _value;
  T get value => _value;
  set value(T value) {
    if (_value == value) {
      return;
    }
    _value = value;
    if (_verificationRules.isNotEmpty) {
      _verifyValue();
    }
    _notifyListeners();
  }

  void _verifyValue() {
    _errors.clear();
    for (var rule in _verificationRules.entries) {
      if (rule.value(value)) {
        _errors.add(rule.key);
      }
    }
  }
}
