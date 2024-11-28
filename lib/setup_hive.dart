import 'package:e_dashboard/infrastructure/account/account_entity.dart';
import 'package:e_dashboard/infrastructure/core/network/hive_box_names.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> setupHive() async {
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(AccountEntityAdapter());

  await Hive.openBox<AccountEntity>(BoxNames.currentUser);
}
