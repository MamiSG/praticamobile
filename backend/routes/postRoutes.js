// backend/routes/postRoutes.js

const express = require('express');
const router = express.Router();
const Post = require('../models/post');

router.get('/', async (req, res) => {
  try {
    const posts = await Post.find()
      .populate('author', 'name') 
      .populate({
        path: 'comments.author',
        select: 'name', 
      });
    res.json(posts);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

router.get('/:postId', async (req, res) => {
  try {
    const post = await Post.findById(req.params.postId)
      .populate('author', 'name')
      .populate({
        path: 'comments.author',
        select: 'name',
      });

    if (!post) return res.status(404).json({ message: 'Post não encontrado' });

    res.json(post);
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
      author: req.body.author, 
      timestamp: new Date(),
    };

    post.comments.push(comment);
    await post.save();

    await post.populate({
      path: 'comments.author',
      select: 'name',
    }).execPopulate();

    const newComment = post.comments[post.comments.length - 1];
    res.status(201).json(newComment);
  } catch (error) {
    console.error("Erro ao adicionar comentário:", error.message);
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;
