import 'package:template/src/repository/objectbox/objectbox_settings_model.dart';
import 'package:template/src/utils/testing_provider.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:template/objectbox.g.dart';

part 'objectbox.g.dart';

@Riverpod(keepAlive: true)
class ObjectBox extends _$ObjectBox {
  @override
  FutureOr<Store> build() async {
    final isTesting = ref.watch(isTestingProvider);
    if (!isTesting.$1) {
      final docsDir = await getApplicationDocumentsDirectory();
      final store = await openStore(directory: p.join(docsDir.path, 'template'));
      return store;
    } else {
      if (isTesting.$1 && isTesting.inMemory) {
        final inMemoryStore = Store(getObjectBoxModel(), directory: 'memory:test-db');
        return inMemoryStore;
      } else {
        final store = await openStore(directory: '/Users/adrian/Development/template/test/test_assets/template');
        return store;
      }
    }
  }

  closeStore() {
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
