#!/bin/bash

echo "╔════════════════════════════════════════════════╗"
echo "║                                                ║"
echo "║       💰 CASHPULSE PLATFORM INSTALLER 💰      ║"
echo "║                                                ║"
echo "╚════════════════════════════════════════════════╝"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed!"
    echo "📥 Please install Node.js 18+ from https://nodejs.org"
    exit 1
fi

echo "✅ Node.js $(node --version) detected"

# Check if MongoDB is installed
if ! command -v mongod &> /dev/null; then
    echo "⚠️  MongoDB is not detected!"
    echo "📥 Please install MongoDB from https://www.mongodb.com/try/download/community"
    echo "   Or use MongoDB Atlas (cloud): https://www.mongodb.com/cloud/atlas"
fi

echo ""
echo "📦 Installing dependencies..."
echo ""

# Install backend dependencies
echo "🔧 Installing backend dependencies..."
cd backend
npm install --legacy-peer-deps
if [ $? -ne 0 ]; then
    echo "❌ Backend installation failed!"
    exit 1
fi
echo "✅ Backend dependencies installed"
cd ..

# Install frontend dependencies
echo "🎨 Installing frontend dependencies..."
cd frontend
npm install --legacy-peer-deps
if [ $? -ne 0 ]; then
    echo "❌ Frontend installation failed!"
    exit 1
fi
echo "✅ Frontend dependencies installed"
cd ..

# Install telegram bot dependencies
echo "🤖 Installing telegram bot dependencies..."
cd telegram-bot
npm install --legacy-peer-deps
if [ $? -ne 0 ]; then
    echo "❌ Telegram bot installation failed!"
    exit 1
fi
echo "✅ Telegram bot dependencies installed"
cd ..

# Setup environment files
echo ""
echo "⚙️  Setting up environment files..."

if [ ! -f backend/.env ]; then
    cp backend/.env.example backend/.env
    echo "✅ Created backend/.env"
    echo "⚠️  Please update JWT_SECRET and MONGODB_URI in backend/.env"
else
    echo "ℹ️  backend/.env already exists"
fi

if [ ! -f frontend/.env ]; then
    cp frontend/.env.example frontend/.env
    echo "✅ Created frontend/.env"
else
    echo "ℹ️  frontend/.env already exists"
fi

if [ ! -f telegram-bot/.env ]; then
    cp telegram-bot/.env.example telegram-bot/.env
    echo "✅ Created telegram-bot/.env"
else
    echo "ℹ️  telegram-bot/.env already exists"
fi

# Create uploads directory
mkdir -p backend/uploads
echo "✅ Created uploads directory"

echo ""
echo "╔════════════════════════════════════════════════╗"
echo "║                                                ║"
echo "║       ✅ INSTALLATION COMPLETE! ✅             ║"
echo "║                                                ║"
echo "╚════════════════════════════════════════════════╝"
echo ""
echo "📋 NEXT STEPS:"
echo ""
echo "1. Start MongoDB:"
echo "   mongod"
echo ""
echo "2. Start Backend (Terminal 1):"
echo "   cd backend"
echo "   npm run dev"
echo ""
echo "3. Start Frontend (Terminal 2):"
echo "   cd frontend"
echo "   npm run dev"
echo ""
echo "4. Start Telegram Bot (Terminal 3):"
echo "   cd telegram-bot"
echo "   npm start"
echo ""
echo "5. Access the platform:"
echo "   Frontend: http://localhost:5173"
echo "   Backend:  http://localhost:5000"
echo ""
echo "📖 Read QUICKSTART.md for detailed instructions"
echo "🔧 Read README.md for complete documentation"
echo ""
echo "💡 Your platform credentials are pre-configured:"
echo "   Bot Token: 7572708038:AAEIhWwcSDk1lC489N6C6hz2ohudhPHTEGM"
echo "   Admin ID: 7590603733"
echo "   Admin: @alo_ne7217"
echo "   Email: blessedsuccess538@gmail.com"
echo "   WhatsApp: +2348085430370"
echo ""
echo "🚀 Happy earning with CashPulse!"
