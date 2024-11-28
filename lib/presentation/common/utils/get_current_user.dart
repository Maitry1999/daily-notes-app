import 'package:e_dashboard/domain/account/account.dart';
import 'package:e_dashboard/infrastructure/account/account_entity.dart';
import 'package:e_dashboard/infrastructure/core/network/hive_box_names.dart';
import 'package:hive/hive.dart';

List<Account> getCurrentUser() {
  final accountBox = Hive.box<AccountEntity>(BoxNames.currentUser);
  return accountBox.values
      .map(
        (e) => e.toDomain(),
      )
      .toList();
}

bool doesCurrentUserExist() {
  final accountBox = Hive.box<AccountEntity>(BoxNames.currentUser);

  return accountBox.values
      .map(
        (e) => e,
      )
      .toList()
      .isNotEmpty;
}
