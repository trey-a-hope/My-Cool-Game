import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_cool_game/domain/core/providers.dart';
import 'package:my_cool_game/domain/notifiers/game_progress_notifier.dart';
import 'package:my_cool_game/presentation/my_cool_game.dart';

class MockWidgetRef extends Mock implements WidgetRef {}

class MockBonfireGame extends Mock implements BonfireGame {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Widget gameWidget;

  const averageAnimationDuration = Duration(seconds: 1);

  setUp(() {
    gameWidget = ProviderScope(
      // Override providers at the root
      overrides: [
        Providers.gameProgressProvider.overrideWith(
          () => GameProgressNotifier(), // Removed the ref parameter
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Consumer(
            builder: (context, ref, _) => MyCoolGame(ref),
          ),
        ),
      ),
    );
  });

  group(
    'Game Overlay',
    () {
      testWidgets(
        'StartOverlay renders by default.',
        (WidgetTester tester) async {
          await tester.pumpWidget(gameWidget);
          await tester.pump(const Duration(seconds: 1));

          final bonfireWidget =
              tester.widget<BonfireWidget>(find.byType(BonfireWidget));

          await tester.pump(averageAnimationDuration);

          // TODO: Coming in future branch...
          // expect(find.byType(StartOverlay), findsOneWidget);
        },
      );
    },
  );
}
