import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:e_dashboard/infrastructure/core/network/hive_box_names.dart';
import 'package:hive/hive.dart';

String? getUserToken() {
  return Hive.box(BoxNames.settingsBox).get(BoxKeys.userToken);
}

String? getRememberToken() {
  return Hive.box(BoxNames.settingsBox).get(BoxKeys.rememberToken);
}

bool? isUserShowIntro() {
  return Hive.box(BoxNames.settingsBox).get(BoxKeys.isUserShowIntro);
}

Future<String?> getDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  } else {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor ?? '';
  }
}
