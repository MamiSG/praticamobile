# manifesto

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

        1. Requisitos e Pré-requisitos

Flutter SDK: Versão mais recente.
Node.js: Para rodar o backend, certifique-se de que Node.js e npm estejam instalados.
MongoDB: O projeto usa MongoDB como banco de dados. Instale o MongoDB localmente
    em server.js da pasta backend, configure o caminho do MongoDB para a sua maquina: const MONGO_URI = 'mongodb://localhost:27017(em 27017 adicione sua porta que aparece no mongo)/manifesto'; 
Instale as dependências do Node.js:
    npm install
Inicie o servidor do banco (caminho dele será até a ponta backend):
    node server.js

        3. Configuração do Frontend (Flutter)

Navegue até a Pasta do Projeto Flutter.
No terminal, execute o comando para instalar as dependências do Flutter:
    flutter pub get
Localize o arquivo api_service.dart (ou similar) no projeto Flutter, Atualize a variável apiUrl para apontar para o servidor backend:
    static const String apiUrl = 'http://10.0.2.2:5000'; (em 10.0.2.2 use seu ipv4, provavel ja esteja com um meu de teste pq esqueço de mudar rs)
Com o servidor backend rodando, inicie o aplicativo Flutter:
    flutter run

