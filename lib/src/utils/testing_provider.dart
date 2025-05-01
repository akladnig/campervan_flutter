import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'testing_provider.g.dart';

@Riverpod(keepAlive: true)
class IsTesting extends _$IsTesting {
  @override
  (bool, {bool inMemory}) build() {
    return (false, inMemory: true);
  }

  (bool, {bool inMemory}) set(bool testing, {bool inMemory = true}) {
    state = (testing, inMemory: inMemory);
    return state;
  }
}
