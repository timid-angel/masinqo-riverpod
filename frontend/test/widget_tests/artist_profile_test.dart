import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/screens/artist_profile.dart';
import 'package:masinqo/presentation/widgets/profile_mgmt_section_title.dart';

void main() {
  group('Artist Profile Test', () {
    testWidgets('Artist Profile UI', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ArtistProfile(
            initialData: {"name": "test_initial", "email": "test_initial"},
          ),
        ),
      );

      expect(find.byType(ClipOval), findsOneWidget);
      expect(find.byType(SectionTitle), findsExactly(2));
      expect(find.byType(RoundedInputField), findsNWidgets(4));
      expect(find.text("test_initial"), findsNWidgets(2));
      expect(find.text('Submit'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Rounded Input Field Test', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RoundedInputField(
              placeholder: "Enter new username",
              controller: TextEditingController(text: ""),
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text("Enter new username"), findsOneWidget);
    });
  });
}
