import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manifesto/screens/feed_screen.dart';

void main() {
  testWidgets('FeedScreen displays a message when there are no posts',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FeedScreen(),
      ),
    );

    expect(find.text('Nenhuma dúvida postada ainda!'), findsOneWidget);
  });
}
