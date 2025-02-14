import 'dart:developer';

import 'package:e_dashboard/domain/core/math_utils.dart';
import 'package:e_dashboard/presentation/core/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_dashboard/application/auth/auth_status/auth_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'splashPage')
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthStatusBloc, AuthStatusState>(
      listener: (context, state) {
        state.map(
          initial: (_) {},
          authenticated: (Authenticated value) async {
            log('authenticated');
            await Future.delayed(
              const Duration(seconds: 1),
              () {
                context.router.replace(PageRouteInfo(LoginView.name));
              },
            );
          },
          unauthenticated: (Unauthenticated value) async {
            log('unauthenticated');
            await Future.delayed(
              const Duration(seconds: 1),
              () {
                context.router.replace(PageRouteInfo(RegisterView.name));
              },
            );
          },
        );
      },
      child: Scaffold(
        body: Center(
          child: FlutterLogo(
            size: getSize(150),
          ),
        ),
      ),
    );
  }
}
