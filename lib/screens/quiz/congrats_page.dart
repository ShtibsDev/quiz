import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz/services/firestore.dart';
import 'package:quiz/services/models.dart';

class CongratsPage extends StatelessWidget {
  final Quiz quiz;
  const CongratsPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Congrats! You completed the ${quiz.title} quiz',
            textAlign: TextAlign.center,
          ),
          const Divider(),
          Image.asset('assets/congrats.gif'),
          const Divider(),
          ElevatedButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            icon: const Icon(FontAwesomeIcons.check),
            label: const Text(' Mark Complete!'),
            onPressed: () {
              FirestoreService().updateUserReport(quiz);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/topics',
                (route) => false,
              );
            },
          )
        ],
      ),
    );
  }
}
