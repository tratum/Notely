import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/app.theme.dart';
import '../views/view.splash/splash.view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyB8wjGRWellh8JSMyytYEc5mT8xN0AeRWo",
        appId: "1:668389272392:android:67262f1825fc50d8d6217d",
        messagingSenderId: "668389272392",
        projectId: "notely-00"),
    name: "Notely",
  );
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  final appTitle = 'Notely';

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appTitle,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const SplashView(),
      supportedLocales: {const Locale('en', '')},
      debugShowCheckedModeBanner: false,
    );
  }
}
