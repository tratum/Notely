import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notely/Screens/Splash/splash_screen.dart';
import 'package:notely/themes/color_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBRBgRWFezxr_UbnE_ylpv7ClS-sbxsKbA",
      appId: "1:865982051920:android:c8691f8f47cd453efd0355",
      messagingSenderId: "865982051920",
      projectId: "to-do-app-5fdeb",
    ),
  );
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  final appTitle = 'Notely';

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appTitle,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const SplashScreen(),
      supportedLocales: {const Locale('en', '')},
      debugShowCheckedModeBanner: false,
    );
  }
}
