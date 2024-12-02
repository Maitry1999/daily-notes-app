// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:e_dashboard/application/auth/auth_status/auth_status_bloc.dart'
    as _i363;
import 'package:e_dashboard/application/auth/login/login_bloc.dart' as _i699;
import 'package:e_dashboard/application/auth/register/register_bloc.dart'
    as _i508;
import 'package:e_dashboard/application/dashboard/dashboard_bloc.dart' as _i227;
import 'package:e_dashboard/domain/auth/i_auth_facade.dart' as _i194;
import 'package:e_dashboard/infrastructure/auth/auth_facade.dart' as _i69;
import 'package:e_dashboard/infrastructure/core/network/injectable_module.dart'
    as _i216;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i227.DashboardBloc>(() => _i227.DashboardBloc());
    gh.lazySingleton<_i216.ApiService>(() => _i216.ApiService());
    gh.lazySingleton<_i194.IAuthFacade>(
        () => _i69.AuthFacade(gh<_i216.ApiService>()));
    gh.factory<_i699.LoginBloc>(() => _i699.LoginBloc(gh<_i194.IAuthFacade>()));
    gh.factory<_i363.AuthStatusBloc>(
        () => _i363.AuthStatusBloc(gh<_i194.IAuthFacade>()));
    gh.factory<_i508.RegisterBloc>(
        () => _i508.RegisterBloc(gh<_i194.IAuthFacade>()));
    return this;
  }
}
