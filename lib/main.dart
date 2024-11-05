import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/feed_screen.dart';
import 'screens/new_post_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App LGBT',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/feed': (context) => FeedScreen(),
        '/new_topic': (context) =>
            NewPostScreen(onPostCreated: (title, description) {}),
      },
    );
  }
}
