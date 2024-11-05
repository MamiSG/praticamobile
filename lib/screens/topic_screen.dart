import 'package:flutter/material.dart';

class TopicScreen extends StatefulWidget {
  final String title;
  final String description;

  TopicScreen({required this.title, required this.description});

  @override
  _TopicScreenState createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  // Lista de respostas (inicialmente vazia)
  List<String> responses = [];

  // Controlador de texto para a nova resposta
  final TextEditingController _responseController = TextEditingController();

  // Função para adicionar uma resposta
  void _addResponse() {
    final response = _responseController.text;
    if (response.isNotEmpty) {
      setState(() {
        responses.add(response);
      });
      _responseController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes da Dúvida"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exibe o título e a descrição da dúvida
            Text(
              widget.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              widget.description,
              style: TextStyle(fontSize: 16),
            ),
            Divider(height: 30),

            // Lista de respostas
            Expanded(
              child: ListView.builder(
                itemCount: responses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.comment),
                    title: Text(responses[index]),
                  );
                },
              ),
            ),

            // Caixa de texto para adicionar uma nova resposta
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _responseController,
                    decoration: InputDecoration(
                      labelText: "Adicionar resposta",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.pinkAccent),
                  onPressed: _addResponse,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
