import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/screens/quiz/quiz_state.dart';
import 'package:quiz/services/models.dart';

class StartPage extends StatelessWidget {
  final Quiz quiz;
  const StartPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    QuizState state = Provider.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(quiz.title, style: Theme.of(context).textTheme.headlineMedium),
          const Divider(),
          Expanded(child: Text(quiz.description)),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: state.nextPage,
                label: const Text('Start Quiz!'),
                icon: const Icon(Icons.poll),
              )
            ],
          )
        ],
      ),
    );
  }
}
