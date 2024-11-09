import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import 'new_post_screen.dart';
import 'login_screen.dart';
import 'topic_screen.dart';

class FeedScreen extends StatefulWidget {
  final User currentUser;

  FeedScreen({required this.currentUser});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ApiService apiService = ApiService();
  List<Map<String, dynamic>> posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    try {
      final fetchedPosts = await apiService.fetchPosts();
      setState(() {
        posts = fetchedPosts;
      });
    } catch (e) {
      print('Erro ao carregar posts: $e');
    }
  }

  Future<void> _addPost(String title, String description) async {
    try {
      print(
          "Tentando criar um post com título: $title e descrição: $description");
      await apiService.createPost(title, description, widget.currentUser.id);
      _loadPosts();
    } catch (e) {
      print('Erro ao criar post: $e');
    }
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _navigateToTopicScreen(Map<String, dynamic> post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TopicScreen(post: post, currentUser: widget.currentUser),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feed de Dúvidas"),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
            tooltip: "Sair",
          ),
        ],
      ),
      body: posts.isEmpty
          ? Center(
              child: Text(
                "Nenhuma dúvida postada ainda!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      post['title'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Autor: ${post['author']['name']}"),
                        SizedBox(height: 8),
                        Text(
                          post['description'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    onTap: () => _navigateToTopicScreen(post),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPostScreen(onPostCreated: _addPost),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
