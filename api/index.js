const express = require('express');
const { createServer } = require('http');
const path = require('path');

const app = express();
const httpServer = createServer(app);

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

// Import routes (if any)
// const { registerRoutes } = require('../server/routes');

// Serve static files from dist/public
app.use(express.static(path.join(__dirname, '../dist/public')));

// API routes
app.use('/api', (req, res) => {
  res.json({ message: 'API endpoint' });
});

// Catch all handler - serve index.html for client-side routing
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, '../dist/public/index.html'));
});

// Vercel serverless function export
module.exports = (req, res) => {
  // For Vercel, we need to handle the request through Express
  // But Vercel expects a function, not an Express app directly
  // So we'll use a different approach
  return app(req, res);
};



