const express = require('express');
const router = express.Router();
const User = require('../models/user');

router.post('/register', async (req, res) => {
  try {
    const newUser = new User(req.body);
    await newUser.save();
    res.status(201).json(newUser);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

router.post('/login', async (req, res) => {
  try {
    const user = await User.findOne({ email: req.body.email });
    if (user && user.password === req.body.password) {
      res.json(user);
    } else {
      res.status(400).json({ message: 'Credenciais inválidas' });
    }
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;