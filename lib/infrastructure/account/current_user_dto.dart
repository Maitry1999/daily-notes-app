import 'package:e_dashboard/domain/account/account.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'current_user_dto.freezed.dart';
part 'current_user_dto.g.dart';

@freezed
class CurrentUserDTO with _$CurrentUserDTO {
  const CurrentUserDTO._();
  const factory CurrentUserDTO({
    UserDTO? user,
    String? token,
  }) = _CurrentUserDTO;
  Account toDomain() {
    return Account(
      token: token,
      user: user?.toDomain(),
    );
  }

  factory CurrentUserDTO.fromDomain(Account account) {
    return CurrentUserDTO(
      token: account.token,
      user: UserDTO.fromDomain(account.user),
    );
  }
  factory CurrentUserDTO.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserDTOFromJson(json);
}

@freezed
class UserDTO with _$UserDTO {
  const UserDTO._();
  const factory UserDTO({
    String? email,
    String? id,
  }) = _User;
  UserDetail toDomain() {
    return UserDetail(
      email: email,
      id: id,
    );
  }

  factory UserDTO.fromDomain(UserDetail? account) {
    return UserDTO(
      email: account?.email,
      id: account?.id,
    );
  }
  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);
}
