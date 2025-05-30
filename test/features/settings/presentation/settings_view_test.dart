import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// A testing utility which creates a [ProviderContainer] and automatically
/// disposes it at the end of the test.
ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}

void main() {
  // testWidgets('Settings Widget Test', (tester) async {
  //   await tester.pumpWidget(
  //     const ProviderScope(
  //       child: MaterialApp(
  //         home: SettingsView(),
  //       ),
  //     ),
  //   );
  //   final themeDropdownFinder = find.byWidget(ThemeDropdown());
  //   expect(themeDropdownFinder, findsOneWidget);
  // });
}
