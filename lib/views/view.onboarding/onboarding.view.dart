import 'package:flutter/material.dart';

import '../../services/auth.service.dart';
import '../../views/view.home/home.view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          height: MediaQuery.of(context).size.height,
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Welcome',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontFamily: 'Alata',
                          fontWeight: FontWeight.w800,
                          fontSize: 50,
                          color: theme.brightness == Brightness.dark
                              ? const Color(0XFFFFFFFF)
                              : const Color(0xFF000000),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 29, right: 29),
                      child: Text(
                        'Write  your  Worries  Away !',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontFamily: 'Alata',
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: theme.brightness == Brightness.dark
                              ? const Color(0XFFFFFFFF)
                              : const Color(0xFF414A4C),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.7,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://tratum.github.io/cloud-asset-storage/images/notely/image.onboarding.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () async {
                      await AuthServiceHandler.signInAnonymously()
                          .whenComplete(() => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeView()),
                              ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.brightness == Brightness.dark
                          ? const Color(0xFFFEF7F3)
                          : const Color(0xFFFDEADE),
                      elevation: 12,
                      foregroundColor: const Color(0xFF000000),
                      padding: const EdgeInsets.fromLTRB(60, 18, 60, 18),
                      textStyle: const TextStyle(
                        fontFamily: 'Alata',
                        fontWeight: FontWeight.w800,
                        fontSize: 34,
                      ),
                    ),
                    child: const Text('Get Started'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
