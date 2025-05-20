import 'package:campervan/src/repository/objectbox/objectbox_settings_model.dart';
import 'package:campervan/src/utils/testing_provider.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:campervan/objectbox.g.dart';

part 'objectbox.g.dart';

@Riverpod(keepAlive: true)
class ObjectBox extends _$ObjectBox {
  @override
  FutureOr<Store> build() async {
    final isTesting = ref.watch(isTestingProvider);
    if (!isTesting.$1) {
      final docsDir = await getApplicationDocumentsDirectory();
      final store = await openStore(directory: p.join(docsDir.path, 'campervan'));
      return store;
    } else {
      if (isTesting.$1 && isTesting.inMemory) {
        final inMemoryStore = Store(getObjectBoxModel(), directory: 'memory:test-db');
        return inMemoryStore;
      } else {
        final store = await openStore(directory: '/Users/adrian/Development/campervan/test/test_assets/campervan');
        return store;
      }
    }
  }

  void closeStore() {
    state.whenData((store) => store.close());
  }
}

@Riverpod(keepAlive: true)
class SettingsBox extends _$SettingsBox {
  @override
  Future<Box<ObxSettingsModel>> build() async {
    final store = await ref.watch(objectBoxProvider.future);
    final settingsBox = Box<ObxSettingsModel>(store);
    return settingsBox;
  }
}
