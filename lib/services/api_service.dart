import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  static const String apiUrl = 'http://192.168.1.11:5000';

  Future<void> registerUser(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao registrar usuário');
    }
  }

  Future<User> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao fazer login');
    }
  }

  Future<void> createPost(
      String title, String description, String tag, String authorId) async {
    print(
        "Enviando requisição para criar post com title: $title, description: $description, tag: $tag, authorId: $authorId");

    final response = await http.post(
      Uri.parse('$apiUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': title,
        'description': description,
        'tag': tag,
        'author': authorId,
      }),
    );

    print("Código de status da resposta: ${response.statusCode}");
    print("Corpo da resposta: ${response.body}");

    if (response.statusCode != 201) {
      throw Exception('Erro ao criar post');
    }
  }

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    final response = await http.get(Uri.parse('$apiUrl/posts'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      throw Exception('Erro ao buscar posts');
    }
  }

  Future<void> addComment(
      String postId, String content, String authorId) async {
    final response = await http.post(
      Uri.parse('$apiUrl/posts/$postId/comments'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'content': content,
        'author': authorId,
      }),
    );

    print("Código de status da resposta: ${response.statusCode}");
    print("Corpo da resposta: ${response.body}");

    if (response.statusCode != 201) {
      throw Exception('Erro ao adicionar comentário');
    }
  }
}
