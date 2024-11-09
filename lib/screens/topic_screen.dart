import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user.dart';

class TopicScreen extends StatefulWidget {
  final Map<String, dynamic> post;
  final User currentUser;

  TopicScreen({required this.post, required this.currentUser});

  @override
  _TopicScreenState createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController _commentController = TextEditingController();
  List<Map<String, dynamic>> comments = [];

  @override
  void initState() {
    super.initState();

    comments = (widget.post['comments'] as List<dynamic>)
        .map((comment) => Map<String, dynamic>.from(comment))
        .toList();
  }

  Future<void> _addComment() async {
    final content = _commentController.text;
    if (content.isEmpty) return;

    try {
      print("Adicionando comentário para o postId: ${widget.post['_id']}");
      await apiService.addComment(
          widget.post['_id'], content, widget.currentUser.id);

      setState(() {
        comments.add({
          'content': content,
          'author': {'name': widget.currentUser.name},
          'timestamp': DateTime.now().toString(),
        });
      });

      _commentController.clear();
    } catch (e) {
      print('Erro ao adicionar comentário: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post['title']),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post['description'],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Comentários:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return ListTile(
                    title: Text(comment['author']['name']),
                    subtitle: Text(comment['content']),
                    trailing: Text(
                      comment['timestamp'] ?? '',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration:
                        InputDecoration(hintText: 'Adicione um comentário'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
