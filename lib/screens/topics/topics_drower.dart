import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiz/screens/quiz/quiz.dart';
import 'package:quiz/services/models.dart';

class TopicsDrawer extends StatelessWidget {
  final List<Topic> topics;
  const TopicsDrawer({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: topics.length,
        itemBuilder: (context, idx) {
          var topic = topics[idx];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Text(
                  topic.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white70),
                ),
              ),
              QuizList(topic: topic)
            ],
          );
        },
        separatorBuilder: (context, idx) => const Divider(),
      ),
    );
  }
}

class QuizList extends StatelessWidget {
  final Topic topic;
  const QuizList({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: topic.quizzes
            .map((quiz) => Card(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  elevation: 4,
                  margin: const EdgeInsets.all(4),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuizScreen(quizId: quiz.id)));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(
                          quiz.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        subtitle: Text(
                          quiz.description,
                          overflow: TextOverflow.fade,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        leading: QuizBadge(
                          quizId: quiz.id,
                          topic: topic,
                        ),
                      ),
                    ),
                  ),
                ))
            .toList());
  }
}

class QuizBadge extends StatelessWidget {
  final String quizId;
  final Topic topic;
  const QuizBadge({super.key, required this.quizId, required this.topic});

  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    List completed = report.topics[topic.id] ?? [];

    if (completed.contains(quizId)) {
      return const Icon(FontAwesomeIcons.checkDouble, color: Colors.green);
    }

    return const Icon(
      FontAwesomeIcons.solidCircle,
      color: Colors.grey,
    );
  }
}
