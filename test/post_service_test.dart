import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MockClient extends Mock implements http.Client {}

Future<List<Map<String, dynamic>>> fetchPosts(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    List data = json.decode(response.body);
    return data.map((e) => e as Map<String, dynamic>).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}

void main() {
  group('PostService', () {
    test('should filter posts by title containing a specific word', () async {
      final client = MockClient();

      when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts')))
          .thenAnswer((_) async => http.Response(
              json.encode([
                {
                  'id': 1,
                  'title': 'Flutter is awesome',
                  'body': 'Content about Flutter'
                },
                {
                  'id': 2,
                  'title': 'Learning Dart',
                  'body': 'Content about Dart'
                },
                {
                  'id': 3,
                  'title': 'Flutter testing',
                  'body': 'Content about testing'
                }
              ]),
              200));

      final posts = await fetchPosts(client);

      final filteredPosts =
          posts.where((post) => post['title'].contains('Flutter')).toList();

      expect(filteredPosts.length, 2);
      expect(filteredPosts[0]['title'], 'Flutter is awesome');
      expect(filteredPosts[1]['title'], 'Flutter testing');
    });
  });
}
