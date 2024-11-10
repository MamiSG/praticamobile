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

  Future<void> _addPost(String title, String description, String tag) async {
    try {
      await apiService.createPost(
          title, description, tag, widget.currentUser.id);
      _loadPosts();
    } catch (e) {
      print('Erro ao criar post: $e');
    }
  }

  LinearGradient _getGradient(String tag) {
    switch (tag) {
      case 'gay':
        return LinearGradient(
            colors: [Color(0xFF00FF00), Color(0xFFFFFFFF), Color(0xFF0000FF)]);
      case 'lesbica':
        return LinearGradient(
            colors: [Color(0xFFFFA500), Color(0xFFFFFFFF), Color(0xFFFF69B4)]);
      case 'trans':
        return LinearGradient(
            colors: [Color(0xFFFFB6C1), Color(0xFFFFFFFF), Color(0xFFADD8E6)]);
      case 'bi':
        return LinearGradient(
            colors: [Color(0xFFFF1493), Color(0xFF8A2BE2), Color(0xFF0000FF)]);
      case 'queer':
        return LinearGradient(
            colors: [Color(0xFF9370DB), Color(0xFFFFFFFF), Color(0xFF32CD32)]);
      case 'geral':
      default:
        return LinearGradient(colors: [
          Color.fromARGB(141, 255, 0, 0),
          Color.fromARGB(141, 255, 166, 0),
          Color.fromARGB(139, 255, 255, 0),
          Color.fromARGB(144, 0, 128, 0),
          Color.fromARGB(143, 0, 0, 255),
          Color.fromARGB(143, 76, 0, 130)
        ]);
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
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: _getGradient(post['tag']),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        post['title'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 37, 36, 36),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tag: ${post['tag']}",
                            style: TextStyle(
                                color: const Color.fromARGB(179, 54, 54, 54)),
                          ),
                          Text("Autor: ${post['author']['name']}",
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(179, 54, 54, 54))),
                          Text(
                            post['description'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                color: const Color.fromARGB(179, 54, 54, 54)),
                          ),
                        ],
                      ),
                      onTap: () => _navigateToTopicScreen(post),
                    ),
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
