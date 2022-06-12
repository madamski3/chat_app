import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/chat_screen.dart';
import './screens/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (ctx, snapshot) {
        return MaterialApp(
          title: 'FlutterChat',
          theme: ThemeData(
            primarySwatch: Colors.pink,
            backgroundColor: Colors.pink,
            accentColor: Colors.deepPurple,
            accentColorBrightness: Brightness.dark,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.pink),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all(Colors.pink),
                side: MaterialStateProperty.all(BorderSide.none),
              ),
            ),
          ),
          home: const AuthScreen(),
          routes: {
            ChatScreen.routeName: (ctx) => ChatScreen(),
          },
        );
      },
    );
  }
}
