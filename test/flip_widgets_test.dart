import 'package:flip_widgets/flip_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FlipCard flips to show backWidget on tap', (WidgetTester tester) async {
    bool wasTapped = false;

    // Define the FlipCard widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlipCard(
            flipDirection: FlipDirection.horizontal,
            onTap: () {
              wasTapped = true;
            },
            frontWidget: const Text('Front Widget', key: Key('frontWidget')),
            backWidget: const Text('Back Widget', key: Key('backWidget')),
          ),
        ),
      ),
    );

    // Verify that both widgets exist in the widget tree
    expect(find.byKey(Key('frontWidget')), findsOneWidget);
    expect(find.byKey(Key('backWidget')), findsOneWidget);

    // Initially, the back widget should be invisible (opacity = 0)
    final frontWidgetOpacity = tester.widget<Opacity>(
      find.ancestor(of: find.byKey(Key('frontWidget')), matching: find.byType(Opacity)),
    ).opacity;
    expect(frontWidgetOpacity, equals(1.0));

    final backWidgetOpacity = tester.widget<Opacity>(
      find.ancestor(of: find.byKey(Key('backWidget')), matching: find.byType(Opacity)),
    ).opacity;
    expect(backWidgetOpacity, equals(0.0));

    // Simulate a tap on the FlipCard
    await tester.tap(find.byType(FlipCard));
    await tester.pumpAndSettle();

    // Verify the animation completed: front widget becomes invisible, back widget visible
    final updatedFrontWidgetOpacity = tester.widget<Opacity>(
      find.ancestor(of: find.byKey(Key('frontWidget')), matching: find.byType(Opacity)),
    ).opacity;
    expect(updatedFrontWidgetOpacity, equals(0.0));

    final updatedBackWidgetOpacity = tester.widget<Opacity>(
      find.ancestor(of: find.byKey(Key('backWidget')), matching: find.byType(Opacity)),
    ).opacity;
    expect(updatedBackWidgetOpacity, equals(1.0));

    // Verify the onTap callback was triggered
    expect(wasTapped, isTrue);
  });
}

