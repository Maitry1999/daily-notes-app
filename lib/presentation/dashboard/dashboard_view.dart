import 'package:e_dashboard/application/dashboard/dashboard_bloc.dart';
import 'package:e_dashboard/injection.dart';
import 'package:e_dashboard/presentation/common/widgets/base_text.dart';
import 'package:e_dashboard/presentation/common/widgets/custom_appbar.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'DashboardView')
class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<DashboardBloc>()..add(DashboardEvent.getCurrentTime()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Attendance System',
              actions: [],
            ),
            body: Center(
              child: BaseText(text: 'text'),
            ),
          );
        },
      ),
    );
  }
}
