# Property and Commands for ChangeNotifier

The package contains the following decorating classes: `Property<T>`, `Command`, `ParameterizedCommand<T>`, `AsyncCommand`, `ParameterizedAsyncCommand<T>`. These classes can be useful when creating viewmodels based on classes extending ChangeNotifier.

## Example #1

![The work of the example #1](/screenshot/example_1.gif)

Properties and commands are defined in the viewmodel class `class FirstPageNotifier extends ChangeNotifier`.

### Property

To store the counter value

```dart
late final outputProperty = Property<int>(
    initialValue: 0,
    notifyListeners: notifyListeners,
);
```
The initial value of the property is set and the method `notifyListeners()` is called if
the value of this property changes.

In the `build(BuildContext context)` method of the `FirstPage extends StatelessWidget` class
we get a tracked reference to the property value

```dart
final output =
    FirstPageInheritedNotifier.watchNotifier(context).outputProperty.value;
```

the output of the value is as follows

```dart
Text(
    output.toString(),
    style: Theme.of(context).textTheme.headlineLarge,
),
```

### Commands

Two commands have been created for increment and decrement of the counter

```dart
late final incrementCommand = Command(
    action: () => outputProperty.value += 1,
    canAction: () => outputProperty.value < 3,
  );

  late final decrementCommand = Command(
    action: () => outputProperty.value -= 1,
    canAction: () => outputProperty.value > 0,
  );
```
Methods that change the value of the counter property are passed as arguments for the `action` parameter.
Methods that limit the range of counter values are passed as arguments for the `canAction` parameter, which restricts the availability of the command to execute.

In the `FirstPage` class in the `build(BuildContext context)` method getting links to commands

```dart
final incrementCommand =
    FirstPageInheritedNotifier.readNotifier(context).incrementCommand;
final decrementCommand =
    FirstPageInheritedNotifier.readNotifier(context).decrementCommand;
```
Using commands to operate buttons

```dart
ElevatedButton(
    onPressed: decrementCommand.canExecute()
        ? decrementCommand.execute
        : null,
    child: const Icon(Icons.exposure_minus_1),
),
```
and

```dart
ElevatedButton(
    onPressed: incrementCommand.canExecute()
        ? incrementCommand.execute
        : null,
    child: const Icon(Icons.plus_one),
),
```
You can see that in the method of the `onPressed` parameter the possibility of executing the command is checked which affects the availability of the button for clicking.


## Example #2

![The work of the example #2](/screenshot/example_2.gif)

The properties and command are defined in the viewmodel class `SecondPageNotifier extends ChangeNotifier`.

### Property

To display the counter value, one property is defined, which is set only by its initial value.

```dart
final outputProperty = Property<int>(initialValue: 0);
```

In the `SecondPage` class in the `build(BuildContext context) method` getting a tracked reference to the property value

```dart
final output =
    SecondPageInheritedNotifier.watchNotifier(context).outputProperty.value;
```

for displaying the property value

```dart
Text(
    output.toString(),
    style: Theme.of(context).textTheme.headlineLarge,
),
```

### Command

One common parameterized command is defined for the buttons,
which, when called for execution, takes an `int` value as an argument.

```dart
late final changeCommand = ParameterizedCommand<int>(
    action: (value) => outputProperty.value += value,
    notifyListeners: notifyListeners,
);
```

When executing the command method, `notifyListeners()` is called.

In the `SecondPage` class in the `build(BuildContext context)` method we get a link to the command

```dart
final command =
        SecondPageInheritedNotifier.readNotifier(context).changeCommand;
```

Using the command for buttons looks like this

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

## Example #3

![The work of the example #3](/screenshot/example_3.gif)

In the viewmodel class `ThirdPageNotifier extends ChangeNotifier`, three properties and a command are defined.

### Properties

The `CheckboxListTile` property is set with the `notifyListeners()` call.

```dart
late final isEnabledProperty = Property<bool>(
    initialValue: false,
    notifyListeners: notifyListeners,
);
```

Next, in `_Third Page State` we get a tracked reference to this property

```dart
final isEnabledProperty =
    ThirdPageInheritedNotifier.watchNotifier(context).isEnabledProperty;
```
and we use it this way

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
```

A property is set for `TextField` with a call to `notifyListeners()` and verification rules.

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
For the verification rule, a text message for the user is specified as the key,
and the method returning `true` is specified as the value.

In the `InputTextWidget` we get references to the properties

```dart
final isEnabledProperty =
        ThirdPageInheritedNotifier.watchNotifier(context).isEnabledProperty;
final inputProperty =
    ThirdPageInheritedNotifier.readNotifier(context).inputProperty;
```
and we use it this way

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
In this line `errorText: inputProperty.hasErrors ? inputProperty.errors[0] : null,` the
logic of displaying error messages to the user when entering data is defined.

The accessibility of the `TextField` for input is tied to the value of the `CheckBoxListTile` via
the `isEnabledProperty` property in this line `enabled: isEnabledProperty.value,`.

The `inputProperty` property updates its value in the method defined for `onChanged`.

A simple property is used to output the result
`final outputProperty = Property<String>(initialValue: '');`.


### Command

The example uses one asynchronous command for the button

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

The availability of the button depends on the presence of errors when entering using
the parameter `canAction: () => inputProperty.hasErrors == false,`.

When executing the command method, `notifyListeners()` is called.

In `_ThirdPageState` we get a link to the command

```dart
final submitCommand =
    ThirdPageInheritedNotifier.readNotifier(context).submitCommand;
```
and we use the command for the button in this way.

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

## Example #4

![The work of the example #4](/screenshot/example_4.gif)

One property and three commands are defined in the `FourthPageNotifier extends ChangeNotifier` viewmodel class.

### Property

A property has been created to display the list.

```dart
final peopleProperty = Property<List<Person>>(
    initialValue: <Person>[],
);
```

In the `PeopleListViewWidget` we get a tracked reference to the property.

```dart
final people =
    FourthPageInheritedNotifier.watchNotifier(context).peopleProperty.value;
```

Displaying a collection of people using `ListView.builder()` and `ListTile`.

```dart
ListView.builder(
    itemCount: people.length,
    itemBuilder: (context, index) {
        final person = people[index];
        return ListTile(
            onTap: () async {...},
            title: Text(person.fullName),
            subtitle: Text('ID: ${person.id}'),
            trailing: TextButton(...),
        );
    },
),
```

### Commands

To implement CRUD operations on a collection of people , three parameterized asynchronous commands have been created: `addCommand`, `removeCommand`, `updateCommand`.

Example on `addCommand`.

```dart
late final addCommand = ParameterizedAsyncCommand<List<String>>(
    action: (value) async {
      await _db.create(names: value);
      peopleProperty.value = await _db.getPeople();
    },
    notifyListeners: notifyListeners,
);
```
In `Composerwidget` in the `Widget build(BuildContext context) method` we get a link
to the command.

```dart
final command =
    FourthPageInheritedNotifier.readNotifier(context).addCommand;
```

We use the command in this way

```dart
TextButton(
    onPressed: () async {
        final names = <String>[
            firstNameController.text,
            lastNameController.text,
        ];
        await command(names);
        firstNameController.clear();
        lastNameController.clear();
    },
    child: Text(
    'Add to list',
    style: Theme.of(context).textTheme.titleMedium,
))
```
