import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/app_binding.dart';
import 'constants/app_pages.dart';
import 'controllers/auth_controller.dart';
import 'services/auth_api_service.dart';
import 'services/oauth_client_service.dart';

void main()async {
    await initializeApp();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
       debugShowCheckedModeBanner: false,
      theme: ThemeData(
         primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
       initialRoute: Routes.HOME,
      initialBinding: AppBinding(),
      getPages: AppPages.pages,
    );
  }
}

Future<void> initializeApp() async {
  // await GetStorage.init();
  OAuthClientService _OAuthClientService = Get.put(OAuthClientService());
  await _OAuthClientService.initCredentials();
  Get.put(
      AuthController(Get.put(AuthApiService()), Get.put(OAuthClientService())),
      permanent: true);
  log('Initialize');
}
