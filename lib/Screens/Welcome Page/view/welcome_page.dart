import 'package:flutter/material.dart';
import 'package:notely/Screens/BottomNavBar/view/bottom_nav_bar.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.background,
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
                            image: AssetImage(
                                'asset/images/Taking-Notes-removebg.png'),
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
                    onPressed: () {
                      if (context.mounted){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const BottomNavBar()),
                        );
                      }
                      // anonymousSignIn(context);
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
