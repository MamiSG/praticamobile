import 'user.dart';

class Post {
  final String title;
  final String description;
  final DateTime timestamp;
  final User author;
  final String tag;

  Post({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.author,
    required this.tag,
  });
}
