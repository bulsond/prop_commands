# Property and Commands for ChangeNotifier

Пакет содержит следующие декарирующие классы: `Property<T>`, `Command`, `ParameterizedCommand<T>`,
`AsyncCommand`, `ParameterizedAsyncCommand<T>`. Данные классы могут быть полезны при создании въюмоделей на основе классов расширяющих ChangeNotifier.

## Пример №1

![Работа примера](/screenshot/example_1.gif)

В классе въюмодели `class FirstPageNotifier extends ChangeNotifier` определены свойство и команды.

### Свойство

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
```

### Команды

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
```.

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


## Пример №2

![Работа примера](/screenshot/example_2.gif)

В классе въюмодели `SecondPageNotifier extends ChangeNotifier` определены свойство и команда.

### Свойство

Для отображения значения счетчика определено одно свойство, которое задано только своим начальным значением.

```dart
final outputProperty = Property<int>(initialValue: 0);
```

В классе `SecondPage` в методе `build(BuildContext context)` получаем отслеживаемую ссылку на значение свойства

```dart
final output =
    SecondPageInheritedNotifier.watchNotifier(context).outputProperty.value;
```

Отображение значения свойства

```dart
Text(
    output.toString(),
    style: Theme.of(context).textTheme.headlineLarge,
),
```

### Команды

Для кнопок опредена одна общая параметризованная команда,
которая при вызове на выполнение в качестве аргумента принимает `int` величину.

```dart
late final changeCommand = ParameterizedCommand<int>(
    action: (value) => outputProperty.value += value,
    notifyListeners: notifyListeners,
);
```

При выполнении метода команды происходит вызов `notifyListeners()`.

В классе `SecondPage` в методе `build(BuildContext context)` получаем ссылку на команду

```dart
final command =
        SecondPageInheritedNotifier.readNotifier(context).changeCommand;
```

Использование команды для кнопок выглядит следующим образом

```dart
ElevatedButton(
    onPressed: () => command(-1),
    child: Text(
        '-1',
        style: Theme.of(context).textTheme.titleLarge,
    ),
),

...

ElevatedButton(
    onPressed: () => command(3),
    child: Text(
        '3',
        style: Theme.of(context).textTheme.titleLarge,
    ),
),
```

## Пример №3

![Работа примера](/screenshot/example_3.gif)

В классе въюмодели `ThirdPageNotifier extends ChangeNotifier` определены три свойства и команда.

### Свойства

Для `CheckboxListTile` задано свойство с вызовом `notifyListeners()`.

```dart
late final isEnabledProperty = Property<bool>(
    initialValue: false,
    notifyListeners: notifyListeners,
);
```.

Далее в `_ThirdPageState` получаем отслеживаемую ссылку на это свойство

```dart
final isEnabledProperty =
    ThirdPageInheritedNotifier.watchNotifier(context).isEnabledProperty;
```
и используем таким образом

```dart
CheckboxListTile(
    title: const Text('enable the input line'),
    controlAffinity: ListTileControlAffinity.platform,
    contentPadding: const EdgeInsets.all(50),
    value: isEnabledProperty.value,
    onChanged: (value) {
        isEnabledProperty.value = value!;
    },
),
```.

Для `TextField` задано свойство с вызовом `notifyListeners()` и правилами верификации.

```dart
late final inputProperty = Property<String>(
    initialValue: '',
    notifyListeners: notifyListeners,
    verificationRules: <String, bool Function(String)>{
      'The value cannot be an empty string': (value) => value.isEmpty,
      'The length of the string cannot be less than 3 characters': (value) =>
          value.length < 3,
    },
);
```
Для правила верификации в качестве ключа указывается текстовое
сообщение для пользователя, а в качестве значения метод возвращающий `true`.

В `InputTextWidget` получем ссылки на свойства

```dart
final isEnabledProperty =
        ThirdPageInheritedNotifier.watchNotifier(context).isEnabledProperty;
final inputProperty =
    ThirdPageInheritedNotifier.readNotifier(context).inputProperty;
```
и используем таким образом

```dart
TextField(
    decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Enter the Value',
        errorText: inputProperty.hasErrors ? inputProperty.errors[0] : null,
    ),
    enabled: isEnabledProperty.value,
    controller: controller,
    onChanged: (text) {
        inputProperty.value = text;
    },
),
```
В этой строке `errorText: inputProperty.hasErrors ? inputProperty.errors[0] : null,` определена
логика отображения сообщений пользователю об ошибке при вводе данных.

Доступность `TextField` для ввода привязана к значению `CheckboxListTile` через
свойство `isEnabledProperty` в этой строке `enabled: isEnabledProperty.value,`.

Свойство `inputProperty` обновляет свое значение в методе определенном для `onChanged`.

Для вывода результата используется простое свойство
`final outputProperty = Property<String>(initialValue: '');`.


### Команда

В примере используется одна асинхронная команда для кнопки

```dart
late final submitCommand = AsyncCommand(
    action: () async {
      await Future.delayed(const Duration(milliseconds: 100));
      outputProperty.value = inputProperty.value;
      inputProperty.value = '';
      isEnabledProperty.value = false;
    },
    canAction: () => inputProperty.hasErrors == false,
    notifyListeners: notifyListeners,
);
```

Доступность кнопки зависит от наличия ошибок при вводе с помощью
параметра `canAction: () => inputProperty.hasErrors == false,`.

При выполнении метода команды происходит вызов `notifyListeners()`.

В `_ThirdPageState` получаем ссылку на команду

```dart
final submitCommand =
    ThirdPageInheritedNotifier.readNotifier(context).submitCommand;
```
и используем команду для кнопки таким образом.

```dart
ElevatedButton(
    onPressed: submitCommand.canExecute()
        ? (() async {
            await submitCommand.execute();
            controller.clear();
        })
        : null,
    child: const Icon(Icons.done),
),
```

## Пример №4

![Работа примера](/screenshot/example_4.gif)

В классе въюмодели ` extends ChangeNotifier` определены три свойства и команда.

### Свойства