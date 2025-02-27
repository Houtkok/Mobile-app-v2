import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:week_3_blabla_project/widgets/inputs/num_spin.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

void main() {
  testWidgets('NumSpin Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NumSpin(initialSeats: 3),
      ),
    );

    expect(find.text('3'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('3'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    //handle the case where the button is disabled.
    final removeButtonFinder = find.byIcon(Icons.remove);
    final removeButtonWidget = tester.widget<Widget>(removeButtonFinder);

    if (removeButtonWidget is IconButton) {
      expect(tester.widget<IconButton>(removeButtonFinder).color, BlaColors.greyLight);
    } else if (removeButtonWidget is Icon) {
      expect(removeButtonWidget, isA<Icon>());
    }

    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    expect(find.byType(NumSpin), findsNothing);
  });

  testWidgets('NumSpin Widget Test initial 1', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NumSpin(initialSeats: 1),
      ),
    );

    expect(find.text('1'), findsOneWidget);
    //handle button disable
    final removeButtonFinder = find.byIcon(Icons.remove);
    final removeButtonWidget = tester.widget<Widget>(removeButtonFinder);

    if (removeButtonWidget is IconButton) {
      expect(tester.widget<IconButton>(removeButtonFinder).color, BlaColors.greyLight);
    } else if (removeButtonWidget is Icon) {
      expect(removeButtonWidget, isA<Icon>());
    }

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    expect(find.byType(NumSpin), findsNothing);
  });
}