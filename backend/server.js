// server.js

const express = require('express');
const http = require('http'); // Required for Socket.io
const socketIo = require('socket.io'); // Real-time communication
const dotenv = require('dotenv');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const rateLimit = require('express-rate-limit');
const connectDB = require('./config/db');

// Import Routes
const authRoutes = require('./routes/authRoutes');
const productRoutes = require('./routes/productRoutes');
const consultantRoutes = require('./routes/consultantRoutes');
const chatRoutes = require('./routes/chatRoutes');
const locationRoutes = require('./routes/locationRoutes');

dotenv.config();
connectDB();

const app = express();
const server = http.createServer(app);
const io = socketIo(server, { cors: { origin: '*' } });

// Security Middleware
app.use(helmet());
app.use(cors());

// Logging Middleware
app.use(morgan('dev'));

// Rate Limiting Middleware
const apiLimiter = rateLimit({
    windowMs: 15 * 60 * 1000, 
    max: 100,
    message: "Too many requests from this IP, please try again later."
});
app.use('/api/', apiLimiter);

// JSON Parsing Middleware
app.use(express.json());

app.use('/api/auth', authRoutes);
app.use('/api/products', productRoutes);
app.use('/api/consultants', consultantRoutes);
app.use('/api/chat', chatRoutes);
app.use('/api/location', locationRoutes);

// Socket.io for Real-Time Chat
io.on('connection', (socket) => {
    console.log('✅ A user connected');
    socket.on('sendMessage', (data) => {
        io.emit('receiveMessage', data); 
    });
    socket.on('disconnect', () => {
        console.log('❌ A user disconnected');
    });
});

// Global Error Handling Middleware
app.use((err, req, res, next) => {
    console.error('Server Error:', err);
    res.status(500).json({ message: 'Internal Server Error', error: err.message });
});

// Error Handling Middleware for Unknown Routes
app.use((req, res) => {
    res.status(404).json({ message: 'API route not found' });
});

// Start Server
const PORT = process.env.PORT || 5000;
server.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));
