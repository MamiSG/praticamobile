const express = require('express');
const router = express.Router();
const Post = require('../models/post');

// Rota para criar um post
router.post('/', async (req, res) => {
  try {
    const newPost = new Post(req.body);
    await newPost.save();
    res.status(201).json(newPost);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Rota para listar todos os posts
router.get('/', async (req, res) => {
  try {
    const posts = await Post.find().populate('author', 'name');
    res.json(posts);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

router.post('/:postId/comments', async (req, res) => {
    try {
      const post = await Post.findById(req.params.postId);
      if (!post) return res.status(404).json({ message: 'Post não encontrado' });
  
      const comment = {
        content: req.body.content,
        author: req.body.author, // Deve ser o ID do autor
        timestamp: new Date(),
      };
  
      post.comments.push(comment);
      await post.save();
      res.status(201).json(comment);
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  });

// Rota para adicionar um comentário a um post
router.post('/:postId/comments', async (req, res) => {
    try {
      const post = await Post.findById(req.params.postId);
      if (!post) return res.status(404).json({ message: 'Post não encontrado' });
  
      const comment = {
        content: req.body.content,
        author: req.body.author, 
        timestamp: new Date(),
      };
  
      post.comments.push(comment);
      await post.save();
      res.status(201).json(comment);
    } catch (error) {
      console.error("Erro ao adicionar comentário:", error.message);
      res.status(500).json({ message: error.message });
    }
  });

module.exports = router;