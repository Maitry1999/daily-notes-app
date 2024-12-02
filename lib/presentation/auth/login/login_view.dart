import 'package:auto_route/auto_route.dart';
import 'package:e_dashboard/application/auth/login/login_bloc.dart';
import 'package:e_dashboard/domain/core/math_utils.dart';
import 'package:e_dashboard/injection.dart';
import 'package:e_dashboard/presentation/common/utils/app_focus.dart';
import 'package:e_dashboard/presentation/common/utils/flushbar_creator.dart';
import 'package:e_dashboard/presentation/common/widgets/custom_appbar.dart';
import 'package:e_dashboard/presentation/common/widgets/custom_text_field.dart';
import 'package:e_dashboard/presentation/core/app_router.gr.dart';
import 'package:e_dashboard/presentation/core/buttons/common_button.dart';
import 'package:e_dashboard/presentation/core/style/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'LoginView')
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Login',
      ),
      body: BlocProvider(
        create: (context) => getIt<LoginBloc>(),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            state.authFailureOrSuccessOption.fold(
              () {},
              (either) => either.fold(
                (failure) {
                  showError(
                    message: failure.maybeMap(
                      showAPIResponseMessage: (value) => value.message,
                      networkError: (value) =>
                          'Please check your internet connectivity',
                      orElse: () => "Server Error. Try again later.",
                    ),
                  ).show(context);
                },
                (_) {
                  context.router.replace(PageRouteInfo(DashboardView.name));
                },
              ),
            );
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                AppFocus.unfocus(context);
              },
              child: Form(
                autovalidateMode: state.showErrorMessages
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: getSize(16),
                    vertical: getSize(16),
                  ),
                  children: [
                    CustomTextField(
                      labelText: 'Email',
                      onChanged: (p0) => context.read<LoginBloc>().add(
                            LoginEvent.emailChanged(p0),
                          ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (p0, p1) => state.emailAddress.value.fold(
                        (l) => l.maybeMap(
                          invalidEmail: (value) => 'Please enter valid email',
                          empty: (value) => 'Please enter email',
                          orElse: () => null,
                        ),
                        (r) => null,
                      ),
                    ),
                    SizedBox(height: getSize(16)),
                    CustomTextField(
                      labelText: 'Password',
                      obscureText: true,
                      onChanged: (p0) => context.read<LoginBloc>().add(
                            LoginEvent.passwordChanged(p0),
                          ),
                      validator: (p0, p1) => state.password.value.fold(
                        (l) => l.maybeMap(
                          empty: (value) => 'Please enter password',
                          shortPassword: (value) =>
                              'Password should be at least 8 characters',
                          orElse: () => null,
                        ),
                        (r) => null,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: getSize(16)),
                    CommonButton(
                      buttonText: 'Login',
                      isSubmitting: state.isSubmitting,
                      onPressed: () {
                        context.read<LoginBloc>().add(
                              LoginEvent.loginPressed(),
                            );
                      },
                    ),
                    SizedBox(height: getSize(16)),
                    Text.rich(
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: 'Sign up',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.green,
                                  decorationColor: AppColors.green,
                                  decoration: TextDecoration.underline,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.router.replace(
                                  PageRouteInfo(RegisterView.name),
                                );
                              },
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
