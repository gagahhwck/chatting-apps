import 'package:chat_ui/firebase_options.dart';
import 'package:chat_ui/pages/chat_page.dart';
import 'package:chat_ui/pages/sign_in_page.dart';
import 'package:chat_ui/pages/sign_up_page.dart';
import 'package:chat_ui/pages/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? ChatPage.routeName
          : WelcomePage.routeName,
      routes: {
        SignUpPage.routeName: (context) => SignUpPage(),
        SignInPage.routeName: (context) => SignInPage(),
        ChatPage.routeName: (context) => ChatPage(),
        WelcomePage.routeName: (context) => WelcomePage(),
      },
    );
  }
}
