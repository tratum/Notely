import 'package:flutter/material.dart';
import 'package:notely/services/auth.service.dart';

import '../../views/view.home/home.view.dart';
import '../../views/view.onboarding/onboarding.view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (AuthServiceHandler.getCurrentUser() != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomeView()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnboardingView()));
      }
    });
    return Container();
  }
}
