const express = require('express');
const mongoose = require('mongoose');
const app = express();
const PORT = process.env.PORT || 5000;
const cors = require('cors'); 

const MONGO_URI = 'mongodb://localhost:27017/manifesto'; 

mongoose.connect(MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

mongoose.connection.once('open', () => {
  console.log('Conectado ao MongoDB');
});

app.use(cors());

app.use(express.json());

const userRoutes = require('./routes/userRoutes');
const postRoutes = require('./routes/postRoutes');

app.use('/users', userRoutes);
app.use('/posts', postRoutes);

app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});