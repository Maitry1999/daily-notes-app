import 'package:e_dashboard/domain/core/environment/environment.dart';
import 'package:e_dashboard/injection.dart';
import 'package:e_dashboard/presentation/core/app_router.dart';
import 'package:e_dashboard/presentation/core/app_widget.dart';
import 'package:e_dashboard/presentation/core/restart_widget.dart';

import 'package:e_dashboard/setup_hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  getIt.registerSingleton<AppRouter>(AppRouter());

  await dotenv.load(fileName: '.env');
  configureInjection(Environment.dev);
  String environment = const String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.dev,
  );
  await setupHive();
  EnvironmentCongig().initConfig(environment);
  runApp(
    RestartWidget(child: AppWidget()),
  );
}
