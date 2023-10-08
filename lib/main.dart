import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:quiz/routes.dart';
import 'package:quiz/services/firestore.dart';
import 'package:quiz/services/models.dart';
import 'package:quiz/theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider(
        create: (_) => FirestoreService().streamReport(),
        initialData: Report(),
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Quiz',
            theme: appTheme,
            routes: appRoutes,
          );
        });
  }
}
