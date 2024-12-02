import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

@freezed
class Account with _$Account {
  const Account._();

  const factory Account({
    UserDetail? user,
    String? token,
  }) = _Account;
}

@freezed
class UserDetail with _$UserDetail {
  const UserDetail._();

  const factory UserDetail({
    String? email,
    String? id, // Mapping "_id" from the JSON
    int? v, // Mapping "__v" from the JSON
  }) = _UserDetail;
}
