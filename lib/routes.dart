import 'screens/about/about.dart';
import 'screens/home/home.dart';
import 'screens/login/login.dart';
import 'screens/profile/profile.dart';
import 'screens/topics/topics.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/topics': (context) => const TopicsScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/about': (context) => const AboutScreen(),
};
