# Property and Commands for ChangeNotifier

Пакет содержит следующие декарирующие классы: `Property<T>`, `Command`, `ParameterizedCommand<T>`,
`AsyncCommand`, `ParameterizedAsyncCommand<T>`. Данные классы могут быть полезны при создании въюмоделей на основе классов расширяющих ChangeNotifier.

## Примеры использования

### Пример №1

![Работа примера](/screenshot/example_1.gif)

В классе въюмодели `class FirstPageNotifier extends ChangeNotifier` определены следующее
свойство и команды.

#### Свойство

Для хранения значения счетчика
```dart
late final outputProperty = Property<int>(
    initialValue: 0,
    notifyListeners: notifyListeners,
);
```
задано начальное значение свойства и вызов метода `notifyListeners()` в случае
изменения значения данного свойства.

В методе `build(BuildContext context)` класса `FirstPage extends StatelessWidget`
получаем отслеживаемую ссылку на значение свойства
```dart
final output =
    FirstPageInheritedNotifier.watchNotifier(context).outputProperty.value;
```,
вывод значения осуществляется следующим образом
```dart
Text(
    output.toString(),
    style: Theme.of(context).textTheme.headlineLarge,
),
```.

#### Команды

Для инкремента и декремента счетчика созданы две команды
```dart
late final incrementCommand = Command(
    action: () => outputProperty.value += 1,
    canAction: () => outputProperty.value < 3,
  );

  late final decrementCommand = Command(
    action: () => outputProperty.value -= 1,
    canAction: () => outputProperty.value > 0,
  );
```.
В качестве аргументов для параметра `action` передаются методы изменяющие значение свойства счетчика.
В качестве аргументов для параметра `canAction`, который ограничивает доступность команды на выполнение,
передаются методы ограничивающие диапозон значений счетчика.

В классе `FirstPage` в методе `build(BuildContext context)` получаем ссылки на команды
```dart
final incrementCommand =
    FirstPageInheritedNotifier.readNotifier(context).incrementCommand;
final decrementCommand =
    FirstPageInheritedNotifier.readNotifier(context).decrementCommand;
```
Использование команд для работы кнопок
```dart
ElevatedButton(
    onPressed: decrementCommand.canExecute()
        ? decrementCommand.execute
        : null,
    child: const Icon(Icons.exposure_minus_1),
),
```
и
```dart
ElevatedButton(
    onPressed: incrementCommand.canExecute()
        ? incrementCommand.execute
        : null,
    child: const Icon(Icons.plus_one),
),
```
Можно видеть, что в методе параметра `onPressed` происходит проверка возможности выполнения команды,
что влияет на доступность кнопки для клика.


### Пример №2

![Работа примера](/screenshot/example_2.gif)

