import 'package:flutter_test/flutter_test.dart';
import '../lib/models/post.dart';

List<Post> filterPostsByKeyword(List<Post> posts, String keyword) {
  return posts.where((post) => post.title.contains(keyword)).toList();
}

void main() {
  group('Post Filter', () {
    test('should return posts that contain the keyword in the title', () {
      final posts = [
        Post(
            title: 'Dúvida sobre Flutter',
            description: 'Descrição 1',
            timestamp: DateTime.now()),
        Post(
            title: 'Dúvida sobre Dart',
            description: 'Descrição 2',
            timestamp: DateTime.now()),
        Post(
            title: 'Testando widgets',
            description: 'Descrição 3',
            timestamp: DateTime.now()),
      ];

      final filteredPosts = filterPostsByKeyword(posts, 'Dúvida');

      expect(filteredPosts.length, 2);
      expect(filteredPosts[0].title, 'Dúvida sobre Flutter');
      expect(filteredPosts[1].title, 'Dúvida sobre Dart');
    });
  });
}
