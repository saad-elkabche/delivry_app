// ignore_for_file: prefer_const_constructors



import 'package:deliveryboy/helpar/routes_helper.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'helpar/get_di.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Daway Livreur',
    options: FirebaseOptions(
      apiKey: 'your_api_key',
      appId: 'your_app_id',
      messagingSenderId: 'your_sender_id',
      projectId: 'your_project_id',
    ),
  );
  await GetStorage.init();
  await di.init();
  runApp(
    DevicePreview(
        enabled: !kReleaseMode,
        builder: (context)=>MyApp()
    )
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: "Gilroy",
      ),
      initialRoute: Routes.initial,
      getPages: getPages,
    );
  }
}
