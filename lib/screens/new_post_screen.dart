import 'package:flutter/material.dart';

class NewPostScreen extends StatefulWidget {
  final Function(String title, String description, String tag) onPostCreated;

  NewPostScreen({required this.onPostCreated});

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String selectedTag = 'geral';

  void _createPost(BuildContext context) {
    final title = _titleController.text;
    final description = _descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty && selectedTag.isNotEmpty) {
      widget.onPostCreated(title, description, selectedTag);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Todos os campos são obrigatórios!")),
      );
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
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedTag,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedTag = newValue;
                  });
                }
              },
              items: <String>['gay', 'lesbica', 'trans', 'bi', 'queer', 'geral']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toUpperCase()),
                );
              }).toList(),
              hint: Text("Selecione uma Tag"),
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
