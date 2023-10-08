import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/services/auth.dart';
import 'package:quiz/services/models.dart';
import 'package:quiz/shared/loading_spinner.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  logout(BuildContext context) async {
    await AuthService().signOut();
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    var user = AuthService().user;

    if (user == null) return const Loader();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(user.displayName ?? 'Guest'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage(user.photoURL ?? 'https://www.gravatar.com/avatar/placeholder'))),
            ),
            Text(
              user.email ?? '',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            Text('${report.total}', style: Theme.of(context).textTheme.displayMedium),
            Text('Quizzes Completed', style: Theme.of(context).textTheme.displayMedium),
            const Spacer(),
            ElevatedButton(onPressed: () => logout(context), child: const Text('Sign Out')),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
