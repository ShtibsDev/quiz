import 'package:flutter/material.dart';
import 'package:quiz/screens/topics/topic_item.dart';
import 'package:quiz/services/firestore.dart';
import 'package:quiz/services/models.dart';
import 'package:quiz/shared/bottom_nav.dart';
import 'package:quiz/shared/error_message.dart';
import 'package:quiz/shared/loading_spinner.dart';

import 'topics_drower.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
        future: FirestoreService().getTopics(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingSpinner();
          } else if (snapshot.hasError) {
            return ErrorMessage(message: snapshot.error.toString());
          } else if (snapshot.hasData) {
            var topics = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.deepPurple,
                title: const Text('Topics'),
              ),
              drawer: TopicsDrawer(
                topics: topics,
              ),
              body: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: topics.map((topic) => TopicItem(topic: topic)).toList(),
              ),
              bottomNavigationBar: const BottomNavBar(),
            );
          } else {
            return const Text('No topics found in Firestore. Check database');
          }
        }));
  }
}
