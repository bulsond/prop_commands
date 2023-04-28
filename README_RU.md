# Property and Commands for ChangeNotifier

Пакет содержит следующие декарирующие классы: `Property<T>`, `Command`, `ParameterizedCommand<T>`,
`AsyncCommand`, `ParameterizedAsyncCommand<T>`. Данные классы могут быть очень полезны при создании въюмоделей на основе классов расширяющих ChangeNotifier.

## Примеры использования

### Пример №1

Создан класс въюмодели `class FirstPageNotifier extends ChangeNotifier`.
В нем создано свойство для хранения значения счетчика
```dart
late final outputProperty = Property<int>(
    initialValue: 0,
    notifyListeners: notifyListeners,
);
```