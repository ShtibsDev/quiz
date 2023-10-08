import 'package:flutter/material.dart';
import 'package:quiz/screens/login/login.dart';
import 'package:quiz/screens/topics/topics.dart';
import 'package:quiz/services/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoginScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        } else if (snapshot.hasData) {
          return const TopicsScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
