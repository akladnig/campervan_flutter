import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:campervan/src/utils/testing_provider.dart';

/// A testing utility which creates a [ProviderContainer] and automatically
/// disposes it at the end of the test.
ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(parent: parent, overrides: overrides, observers: observers);

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('testing provider constructor test', () {
    // Create a ProviderContainer for this test.
    // DO NOT share ProviderContainers between tests.
    final container = createContainer();
    var result = container.read(isTestingProvider);
    expect(result, (false, inMemory: true));
  });
  test('testing provider constructor test', () {
    // Create a ProviderContainer for this test.
    // DO NOT share ProviderContainers between tests.
    final container = createContainer();
    var result = container.read(isTestingProvider.notifier).set(true, inMemory: false);
    expect(result, (true, inMemory: false));
  });
}
