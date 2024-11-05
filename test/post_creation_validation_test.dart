import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:manifesto/screens/new_post_screen.dart';

void main() {
  testWidgets('should validate title and description fields are not empty',
      (WidgetTester tester) async {
    bool postCreated = false;
    void mockOnPostCreated(String title, String description) {
      postCreated = true;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: NewPostScreen(onPostCreated: mockOnPostCreated),
      ),
    );

    final postButton = find.text("Postar");

    await tester.tap(postButton);
    await tester.pump();

    expect(postCreated, isFalse);

    await tester.enterText(find.byType(TextField).at(0), 'Título da dúvida');
    await tester.enterText(find.byType(TextField).at(1), 'Descrição da dúvida');

    await tester.tap(postButton);
    await tester.pump();

    expect(postCreated, isTrue);
  });
}
