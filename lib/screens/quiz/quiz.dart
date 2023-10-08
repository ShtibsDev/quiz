import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiz/screens/quiz/quiz_state.dart';
import 'package:quiz/services/firestore.dart';
import 'package:quiz/services/models.dart';
import 'package:quiz/shared/loading_spinner.dart';
import 'package:quiz/shared/progress_bar.dart';

import 'congrats_page.dart';
import 'question_page.dart';
import 'start_page.dart';

class QuizScreen extends StatelessWidget {
  final String quizId;

  const QuizScreen({super.key, required this.quizId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizState(),
      child: FutureBuilder<Quiz>(
        future: FirestoreService().getQuiz(quizId),
        builder: (context, snapshot) {
          var state = Provider.of<QuizState>(context);

          if (!snapshot.hasData || snapshot.hasError) {
            return const Loader();
          }

          var quiz = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: ProgressBar(value: state.progress),
              leading: IconButton(
                icon: const Icon(FontAwesomeIcons.xmark),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              controller: state.controller,
              onPageChanged: (int idx) => state.progress = (idx / (quiz.questions.length + 1)),
              itemBuilder: (BuildContext context, int idx) {
                if (idx == 0) {
                  return StartPage(quiz: quiz);
                }

                if (idx == quiz.questions.length + 1) {
                  return CongratsPage(quiz: quiz);
                }

                return QuestionPage(question: quiz.questions[idx - 1]);
              },
            ),
          );
        },
      ),
    );
  }
}
