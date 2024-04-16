import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../BottomNavBar/view/bottom_nav_bar.dart';
import '../Welcome Page/controller/welcome_page_controller.dart';
import '../Welcome Page/view/welcome_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  WelcomePageController welcomePageController = Get.put(WelcomePageController());
  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  User? user;

  Future<bool> userTable(User user) async {
    final userDoc = await db.collection('users').doc(user.uid).get();
    return !userDoc.exists;
  }

  void anonymousSignIn(BuildContext context) async {
    UserCredential userCred = await auth.signInAnonymously();
    user = userCred.user;
    if (user != null) {
      welcomePageController.uid.value = user!.uid;
      bool isNewUser = await userTable(user!);

      if (isNewUser) {
        // User is new, navigate to welcome screen
        await db.collection('users').doc(user?.uid).set({
          'uid': user?.uid,
        });
        if (context.mounted){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WelcomePage()),
          );
        }
      }
      else {
        final notesCollection = FirebaseFirestore.instance
            .collection('Notes Data for uid ${welcomePageController.uid.value}');
        await notesCollection.get().then(
              (QuerySnapshot<Map<String, dynamic>> snapshot) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
                snapshot.docs;
            welcomePageController.noteData.value = docs;
          },
        );

        final todoCollection = FirebaseFirestore.instance
            .collection("ToDo Data for uid ${welcomePageController.uid.value}");
        await todoCollection.get().then(
              (QuerySnapshot<Map<String, dynamic>> snapshot) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
                snapshot.docs;
            welcomePageController.todoData.value = docs;
          },
        );
        if (context.mounted){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavBar()),
          );
        }
      }
    }
    else {
      if (kDebugMode) {
        print('User is not authenticated');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then(
            (value) {
      // if (auth.currentUser != null) {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => const BottomNavBar()),
      //   );
      // }
      // else {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => const WelcomePage()),
      //   );
      // }
      anonymousSignIn(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Lottie.asset('asset/lottiefiles/note.json'),
          ),
        ),
      ),
    );
  }
}
