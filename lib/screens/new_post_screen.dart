import 'package:flutter/material.dart';

class NewPostScreen extends StatelessWidget {
  final Function(String title, String description) onPostCreated;

  NewPostScreen({required this.onPostCreated});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _createPost(BuildContext context) {
    final title = _titleController.text;
    final description = _descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      print("Criando post com título: $title e descrição: $description");
      onPostCreated(title, description);
      Navigator.pop(context);
    } else {
      print("Erro: título ou descrição estão vazios");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Novo Post"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Descrição"),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _createPost(context),
              child: Text("Criar"),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
            ),
          ],
        ),
      ),
    );
  }
}
