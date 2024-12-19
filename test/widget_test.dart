import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pet_care_app/main.dart';
import 'package:pet_care_finder/main.dart';

void main() {
  testWidgets('App initializes with HomeScreen', (WidgetTester tester) async {
    // Build the app and trigger a frame
    await tester.pumpWidget(PetCareApp());

    // Verify that the app has the "Pet Care" title
    expect(find.text('Pet Care'), findsOneWidget);

    // Verify that the navigation bar items are present
    expect(find.text('Locate'), findsOneWidget);
    expect(find.text('Products'), findsOneWidget);
    expect(find.text('Consultant'), findsOneWidget);
    expect(find.text('Account'), findsOneWidget);
  });
}
