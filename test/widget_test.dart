import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codex_todo/main.dart';

void main() {
  testWidgets('navigate between tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Dashboard page should be visible initially
    expect(find.text('Dashboard Page'), findsOneWidget);

    // Tap the Todo tab and verify initial state
    await tester.tap(find.text('Todo'));
    await tester.pumpAndSettle();
    expect(find.text('No todos yet'), findsOneWidget);

    // Add a todo item
    await tester.enterText(find.byType(TextField), 'Buy milk');
    await tester.tap(find.text('Add'));
    await tester.pump();

    // Verify the added item appears
    expect(find.text('Buy milk'), findsOneWidget);
  });
}
