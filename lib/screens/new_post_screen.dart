import 'package:flutter/material.dart';

class NewPostScreen extends StatelessWidget {
  final Function(String, String) onPostCreated;

  NewPostScreen({required this.onPostCreated});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova Dúvida"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Título",
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Descrição",
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              onPressed: () {
                final title = _titleController.text;
                final description = _descriptionController.text;
                if (title.isNotEmpty && description.isNotEmpty) {
                  onPostCreated(title, description);
                  Navigator.pop(context);
                }
              },
              child: Text("Postar"),
            ),
          ],
        ),
      ),
    );
  }
}
