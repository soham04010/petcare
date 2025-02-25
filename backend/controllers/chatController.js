const Chat = require('../models/Chat');

// Get chat history between a user and consultant
exports.getChatHistory = async (req, res) => {
    try {
        const { userId, consultantId } = req.params;
        const chat = await Chat.findOne({ userId, consultantId });

        if (!chat) return res.json({ messages: [] }); // No chat history yet

        res.json(chat.messages);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching chat history', error });
    }
};

// Send a new message
exports.sendMessage = async (req, res) => {
    try {
        const { userId, consultantId, sender, message } = req.body;

        let chat = await Chat.findOne({ userId, consultantId });

        if (!chat) {
            chat = new Chat({ userId, consultantId, messages: [] });
        }

        chat.messages.push({ sender, message });
        await chat.save();

        res.json({ message: 'Message sent successfully', chat });
    } catch (error) {
        res.status(500).json({ message: 'Error sending message', error });
    }
};
