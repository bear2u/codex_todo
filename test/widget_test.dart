import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codex_todo/main.dart';

void main() {
  testWidgets('navigate between tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Dashboard page should be visible initially
    expect(find.text('Dashboard Page'), findsOneWidget);

    // Tap the Todo tab and verify
    await tester.tap(find.text('Todo'));
    await tester.pumpAndSettle();
    expect(find.text('Add Todo Page'), findsOneWidget);
  });
}
