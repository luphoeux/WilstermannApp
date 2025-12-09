import 'package:flutter_test/flutter_test.dart';
import 'package:wilstermann_app/main.dart';

void main() {
  testWidgets('App starts smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const WilstermannApp());

    // Verify that Splash Screen appears
    // Just verifying it builds without crashing for now
  });
}
