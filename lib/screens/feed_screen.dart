import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/post.dart';
import 'new_post_screen.dart';
import 'topic_screen.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  // Lista de posts (inicialmente vazia)
  List<Post> posts = [];

  // Método para adicionar um novo post
  void _addPost(String title, String description) {
    final newPost = Post(
      title: title,
      description: description,
      timestamp: DateTime.now(),
    );
    setState(() {
      posts.insert(0, newPost); // Adiciona o post no início da lista
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feed de Dúvidas"),
        backgroundColor: Colors.pinkAccent,
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
                      post.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          post.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          DateFormat('dd/MM/yyyy HH:mm').format(post.timestamp),
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TopicScreen(
                            title: post.title,
                            description: post.description,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        onPressed: () async {
          // Abre a tela de criação de post e recebe o resultado
          final result = await Navigator.push(
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
