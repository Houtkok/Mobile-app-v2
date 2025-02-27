import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:week_3_blabla_project/widgets/actions/blabutton.dart';

void main() {
  testWidgets('PrimaryButton and SecondaryButton interactions', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ButtonTestScreen()));
    //initail state
    expect(find.text('Primary Button'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text('Secondary Button'), findsOneWidget);
    expect(find.byIcon(Icons.remove), findsOneWidget);
    //primary and onpress
    await tester.tap(find.text('Primary Button'));
    await tester.pumpAndSettle();
    expect(find.text('Primary Pressed!'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
    //secondary and onpress
    await tester.tap(find.text('Secondary Button'));
    await tester.pumpAndSettle();
    expect(find.text('Secondary Pressed!'), findsOneWidget);
    expect(find.byIcon(Icons.done_all), findsOneWidget);
  });
}

class ButtonTestScreen extends StatefulWidget {
  const ButtonTestScreen({super.key});

  @override
  State<ButtonTestScreen> createState() => _ButtonTestScreenState();
}

class _ButtonTestScreenState extends State<ButtonTestScreen> {
  String primaryButtonText = 'Primary Button';
  IconData? primaryButtonIcon = Icons.add;
  String secondaryButtonText = 'Secondary Button';
  IconData? secondaryButtonIcon = Icons.remove;

  void _onPrimaryButtonPressed() {
    setState(() {
      primaryButtonText = 'Primary Pressed!';
      primaryButtonIcon = Icons.check;
    });
  }

  void _onSecondaryButtonPressed() {
    setState(() {
      secondaryButtonText = 'Secondary Pressed!';
      secondaryButtonIcon = Icons.done_all;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlaButton(
              text: primaryButtonText,
              icon: primaryButtonIcon,
              isPrimary: true,
              onPressed: _onPrimaryButtonPressed,
            ),
            const SizedBox(height: 16),
            BlaButton(
              text: secondaryButtonText,
              icon: secondaryButtonIcon,
              isPrimary: false,
              onPressed: _onSecondaryButtonPressed,
            ),
            const SizedBox(height: 16),
            BlaButton(
              text: 'Primary No Icon',
              isPrimary: true,
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            BlaButton(
              text: 'Secondary No Icon',
              isPrimary: false,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
