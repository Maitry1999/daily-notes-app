import 'package:auto_route/auto_route.dart';
import 'package:e_dashboard/domain/core/math_utils.dart';
import 'package:e_dashboard/presentation/common/widgets/custom_appbar.dart';
import 'package:e_dashboard/presentation/common/widgets/custom_text_field.dart';
import 'package:e_dashboard/presentation/core/buttons/common_button.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'RegisterView')
class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Register'),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: getSize(16)),
        children: [
          CustomTextField(),
          CustomTextField(),
          CustomTextField(),
          CommonButton(
            buttonText: 'Register',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
