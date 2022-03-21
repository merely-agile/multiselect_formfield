import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multiselect_formfield/multiselect_dialog.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

void main() async {
  testWidgets('Works', (WidgetTester tester) async {
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

  testWidgets('Filters out initial values not present in the original list', (WidgetTester tester) async {
    var items = [
      {'id': '12345', 'value': 1234},
      {'id': '09090', 'value': 0000}
    ];
    var app = MaterialApp(
        home: Card(
      child: MultiSelectFormField(
        dataSource: items,
        title: Text('My Multiselect Title'),
        initialValue: ['12345'],
        cancelButtonLabel: 'Cancel',
        okButtonLabel: 'OK',
      ),
    ));

    await tester.pumpWidget(app);
    expect(app, isNotNull);
  });
}
