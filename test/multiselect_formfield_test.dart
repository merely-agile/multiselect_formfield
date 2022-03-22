import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multiselect_formfield/multiselect_dialog.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

void main() async {
  testWidgets('Displays initial values when present in the provided data source', (WidgetTester tester) async {
    var items = [
      {'id': '12345', 'value': 'Thing 1'},
      {'id': '09090', 'value': 'Thing 2'}
    ];
    var app = MaterialApp(
        home: Card(
      child: MultiSelectFormField(
        dataSource: items,
        title: Text('My Multiselect Title'),
        initialValue: ['12345'],
        cancelButtonLabel: 'Cancel',
        okButtonLabel: 'OK',
        textField: 'value',
        valueField: 'id',
      ),
    ));

    await tester.pumpWidget(app);
    var initialChip = find.widgetWithText(Chip, 'Thing 1');
    expect(initialChip, findsOneWidget);
  });

  testWidgets('Does not error out if an initial value is not present in the provided data source',
      (WidgetTester tester) async {
    var items = [
      {'id': '12345', 'value': 'Thing 1'},
      {'id': '09090', 'value': 'Thing 2'}
    ];
    var app = MaterialApp(
        home: Card(
      child: MultiSelectFormField(
        dataSource: items,
        title: Text('My Multiselect Title'),
        initialValue: ['55555', '12345'],
        cancelButtonLabel: 'Cancel',
        okButtonLabel: 'OK',
        textField: 'value',
        valueField: 'id',
      ),
    ));

    await tester.pumpWidget(app);
    var initialChip = find.text('Thing 1');
    expect(initialChip, findsOneWidget);
  });

  testWidgets('Displays the hint text if no initial values are given.', (WidgetTester tester) async {
    var items = [
      {'id': '12345', 'value': 'Thing 1'},
      {'id': '09090', 'value': 'Thing 2'}
    ];
    var app = MaterialApp(
        home: Card(
      child: MultiSelectFormField(
        dataSource: items,
        title: Text('My Multiselect Title'),
        initialValue: [],
        cancelButtonLabel: 'Cancel',
        okButtonLabel: 'OK',
        textField: 'value',
        valueField: 'id',
      ),
    ));

    await tester.pumpWidget(app);
    var hintText = find.text('Tap to select one or more');
    expect(hintText, findsOneWidget);
  });

  testWidgets('Displays the hint text if the only initial value given does not exist in the data source.',
      (WidgetTester tester) async {
    var items = [
      {'id': '12345', 'value': 'Thing 1'},
      {'id': '09090', 'value': 'Thing 2'}
    ];
    var app = MaterialApp(
        home: Card(
      child: MultiSelectFormField(
        dataSource: items,
        title: Text('My Multiselect Title'),
        initialValue: ['55555'],
        cancelButtonLabel: 'Cancel',
        okButtonLabel: 'OK',
        textField: 'value',
        valueField: 'id',
      ),
    ));

    await tester.pumpWidget(app);
    var hintText = find.text('Tap to select one or more');
    expect(hintText, findsOneWidget);
  });

  testWidgets('MultiSelect Dialog Works', (WidgetTester tester) async {
    var app = MaterialApp(
        home: Card(
      child: MultiSelectDialog(
        items: [],
        title: Text('My Multiselect Title'),
        initialSelectedValues: [],
        cancelButtonLabel: 'Cancel',
        okButtonLabel: 'OK',
      ),
    ));
    await tester.pumpWidget(app);
    expect(app, isNotNull);

    var finder = find.text('My Multiselect Title');
    await tester.tap(finder);
    await tester.pumpAndSettle();
    var okButton = find.text('OK');
    var cancelButton = find.text('Cancel');
    expect(okButton, findsOneWidget);
    expect(cancelButton, findsOneWidget);
  });
}
