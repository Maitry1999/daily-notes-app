import 'package:e_dashboard/domain/account/account.dart';
import 'package:hive/hive.dart';
part 'account_entity.g.dart';

@HiveType(typeId: 1)
class AccountEntity extends HiveObject {
  @HiveField(1)
  UserEntity? user;
  @HiveField(2)
  String? token;

  AccountEntity({
    required this.user,
    required this.token,
  });

  Account toDomain() {
    return Account(
      user: user?.toDomain(),
      token: token,
    );
  }

  factory AccountEntity.fromDomain(Account account) {
    return AccountEntity(
        user: UserEntity.fromDomain(account.user!), token: account.token);
  }
}

@HiveType(typeId: 2)
class UserEntity extends HiveObject {
  @HiveField(1)
  String? email;
  @HiveField(2)
  String? id;
  @HiveField(3)
  int? v;

  UserEntity({
    required this.email,
    required this.id,
    required this.v,
  });

  UserDetail toDomain() {
    return UserDetail(
      email: email,
      id: id,
      v: v,
    );
  }

  factory UserEntity.fromDomain(UserDetail account) {
    return UserEntity(email: account.email, id: account.id, v: account.v);
  }
}
