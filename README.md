# 💰 CashPulse - Naira Investment & Earning Platform

## 🚀 Overview

CashPulse is a fully immersive, interactive, gamified, and animated Naira-based earning and investment platform. Users can deposit, withdraw, invest, mine, play casino games, redeem daily coupons, and earn referral rewards, all managed via a comprehensive dashboard.

### ✨ Key Features

- **💳 Deposit & Withdrawal System** - PalmPay integration with admin approval
- **📈 Investment Plans** - 7 tiers with 40% daily returns for 30 days
- **⛏️ Mining System** - Earn ₦25/minute passively 24/7
- **🎰 Casino Games** - Spin, Dice, Mine, Crash games with multipliers
- **🎫 Daily Coupons** - Redeemable bonus codes
- **👥 Referral System** - Earn ₦200 per referral + multi-level rewards
- **🏆 Gamification** - Achievements, badges, leaderboards, streaks
- **🤖 Telegram Bot** - Complete admin control and notifications
- **🔐 Security** - 2FA, transaction logging, account freeze capability

---

## 📋 Platform Details

- **Platform Name:** CashPulse
- **Support Email:** blessedsuccess538@gmail.com
- **WhatsApp Support:** [+2348085430370](https://wa.me/2348085430370)
- **Telegram Channel:** https://t.me/makingonline217
- **Admin:** @alo_ne7217

### Payment Details (PalmPay)
- **Account Name:** SUCCESS KELECHI BLESSED
- **Account Number:** 8901140537
- **Bank:** PalmPay / PalmPay Limited

---

## 🛠️ Technology Stack

### Frontend
- React.js 18 with Vite
- Redux Toolkit for state management
- Tailwind CSS for styling
- Framer Motion for animations
- Chart.js for data visualization
- Socket.io Client for real-time updates

### Backend
- Node.js with Express.js
- MongoDB with Mongoose
- Socket.io for real-time features
- JWT authentication
- Node-cron for scheduled tasks
- Multer for file uploads

### Telegram Bot
- node-telegram-bot-api
- Integrated with backend API

---

## 📦 Installation

### Prerequisites
- Node.js 18+ and npm
- MongoDB 6+
- Telegram Bot Token (from @BotFather)

### 1. Clone and Install

```bash
# Clone the repository
git clone <repository-url>
cd CashPulse-Platform

# Install backend dependencies
cd backend
npm install

# Install frontend dependencies
cd ../frontend
npm install

# Install telegram bot dependencies
cd ../telegram-bot
npm install
```

### 2. Environment Configuration

**Backend (.env)**
```env
# Server
NODE_ENV=production
PORT=5000
FRONTEND_URL=http://localhost:5173

# Database
MONGODB_URI=mongodb://localhost:27017/cashpulse

# JWT
JWT_SECRET=your_super_secure_jwt_secret_key_here
JWT_EXPIRE=7d

# Telegram Bot
TELEGRAM_BOT_TOKEN=7572708038:AAEIhWwcSDk1lC489N6C6hz2ohudhPHTEGM
ADMIN_TELEGRAM_ID=7590603733
TELEGRAM_CHANNEL=https://t.me/makingonline217

# Platform Details
PLATFORM_NAME=CashPulse
SUPPORT_EMAIL=blessedsuccess538@gmail.com
WHATSAPP_NUMBER=+2348085430370
ADMIN_USERNAME=@alo_ne7217

# Payment Details
PALMPAY_ACCOUNT_NAME=SUCCESS KELECHI BLESSED
PALMPAY_ACCOUNT_NUMBER=8901140537
PALMPAY_BANK_NAME=PalmPay

# Mining Configuration
MINING_RATE_PER_MINUTE=25

# File Upload
MAX_FILE_SIZE=5242880
UPLOAD_PATH=./uploads
```

**Telegram Bot (.env)**
```env
TELEGRAM_BOT_TOKEN=7572708038:AAEIhWwcSDk1lC489N6C6hz2ohudhPHTEGM
ADMIN_TELEGRAM_ID=7590603733
API_BASE_URL=http://localhost:5000/api
WEBHOOK_DOMAIN=your-domain.com
```

**Frontend (.env)**
```env
VITE_API_URL=http://localhost:5000/api
VITE_SOCKET_URL=http://localhost:5000
VITE_PLATFORM_NAME=CashPulse
VITE_SUPPORT_EMAIL=blessedsuccess538@gmail.com
VITE_WHATSAPP_URL=https://wa.me/2348085430370
VITE_TELEGRAM_CHANNEL=https://t.me/makingonline217
```

### 3. Run the Application

```bash
# Start MongoDB
mongod

# Terminal 1: Start Backend
cd backend
npm run dev

# Terminal 2: Start Frontend
cd frontend
npm run dev

# Terminal 3: Start Telegram Bot
cd telegram-bot
npm start
```

### 4. Access the Platform

- **Frontend:** http://localhost:5173
- **Backend API:** http://localhost:5000
- **API Docs:** http://localhost:5000/api-docs

---

## 🤖 Telegram Bot Commands

### Admin Commands

```
/start - Initialize bot
/help - Show all commands

User Management:
/new_users - List recent signups
/user_balance <user_id> - Check user balance
/freeze_account <user_id> - Freeze suspicious account
/unfreeze_account <user_id> - Unfreeze account

Deposits:
/deposits_pending - List pending deposits
/approve_deposit <reference_code> - Approve deposit
/reject_deposit <reference_code> - Reject deposit

Withdrawals:
/withdrawals_pending - List pending withdrawals
/approve_withdrawal <withdrawal_id> - Approve withdrawal
/reject_withdrawal <withdrawal_id> - Reject withdrawal

Investments:
/active_investments - List all active investments
/investment_stats - Get investment statistics

Coupons:
/generate_coupon <amount> <quantity> - Generate coupons
/list_coupons - List all coupons
/delete_coupon <coupon_code> - Delete coupon

Notifications:
/notify <user_id> <message> - Send notification to user
/notify_all <message> - Broadcast to all users

Analytics:
/leaderboard - Show top users
/platform_stats - Get platform statistics
/daily_report - Get daily activity report
```

---

## 📊 Investment Plans

| Plan | Amount (₦) | Daily Return (40%) | Total Return (30 days) |
|------|------------|-------------------|----------------------|
| Starter | 3,000 | 1,200 | 36,000 |
| Basic | 5,000 | 2,000 | 60,000 |
| Silver | 10,000 | 4,000 | 120,000 |
| Gold | 50,000 | 20,000 | 600,000 |
| Platinum | 100,000 | 40,000 | 1,200,000 |
| Diamond | 250,000 | 100,000 | 3,000,000 |
| Elite | 500,000 | 200,000 | 6,000,000 |

*All investments run for 30 days with 40% daily returns*

---

## 🎮 Casino Games

### 1. Spin Game
- Wheel of fortune with multipliers
- Range: 1.01x - 2.50x
- Trap zones lose stake

### 2. Dice Game
- Roll dice and predict outcome
- Multipliers based on prediction accuracy
- High/Low/Exact number betting

### 3. Mine Game
- Grid-based treasure hunt
- Select safe tiles to reveal multipliers
- Hit mine = lose stake

### 4. Crash Game
- Watch multiplier increase
- Cash out before crash
- Higher risk = higher rewards

---

## 🏆 Gamification & Achievements

### Achievement Badges
- 🎉 **First Deposit** - Make your first deposit
- ⛏️ **Mining Streak** - Mine for 7/15/30 consecutive days
- 👥 **Referral Master** - Refer 10/50/100 users
- 🎫 **Coupon Hunter** - Redeem 10/50/100 coupons
- 💎 **Investment Pro** - Complete 5/10/25 investments
- 🎰 **Casino King** - Win 100k/500k/1M in casino

### Leaderboards
- Top Earners (All-time)
- Top Investors (Monthly)
- Top Miners (Weekly)
- Top Referrers (All-time)
- Casino Winners (Daily)

---

## 🔐 Security Features

- JWT token-based authentication
- Optional 2FA with TOTP
- Password hashing with bcrypt
- Rate limiting on API endpoints
- Transaction logging and audit trails
- Account freeze capability for suspicious activity
- Wallet negative balance prevention
- File upload validation and sanitization
- XSS and CSRF protection
- Input validation on all endpoints

---

## 📱 API Documentation

Full API documentation is available at `/api-docs` when the backend is running.

### Key Endpoints

**Authentication**
- `POST /api/auth/signup` - User registration
- `POST /api/auth/login` - User login
- `POST /api/auth/enable-2fa` - Enable 2FA
- `POST /api/auth/verify-2fa` - Verify 2FA token

**Wallet**
- `GET /api/wallet/balance` - Get wallet balance
- `GET /api/wallet/transactions` - Get transaction history

**Deposits**
- `POST /api/deposits/create` - Submit deposit request
- `GET /api/deposits/history` - Get deposit history

**Withdrawals**
- `POST /api/withdrawals/create` - Submit withdrawal request
- `GET /api/withdrawals/history` - Get withdrawal history

**Investments**
- `GET /api/investments/plans` - Get all plans
- `POST /api/investments/invest` - Create investment
- `GET /api/investments/active` - Get active investments

**Mining**
- `POST /api/mining/start` - Start mining
- `POST /api/mining/pause` - Pause mining
- `GET /api/mining/stats` - Get mining statistics

**Casino**
- `POST /api/casino/spin` - Play spin game
- `POST /api/casino/dice` - Play dice game
- `POST /api/casino/mine` - Play mine game
- `POST /api/casino/crash` - Play crash game

**Coupons**
- `POST /api/coupons/redeem` - Redeem coupon
- `GET /api/coupons/history` - Get redemption history

**Referrals**
- `GET /api/referrals/stats` - Get referral statistics
- `GET /api/referrals/tree` - Get referral tree

---

## 🚀 Deployment

### Using Docker

```bash
# Build and run with docker-compose
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Manual Deployment

1. **Setup Production Database**
   - MongoDB Atlas or self-hosted MongoDB
   - Update MONGODB_URI in .env

2. **Deploy Backend**
   - Use PM2 for process management
   - Configure nginx as reverse proxy
   - Enable SSL with Let's Encrypt

3. **Deploy Frontend**
   - Build: `npm run build`
   - Serve with nginx or deploy to Vercel/Netlify

4. **Deploy Telegram Bot**
   - Run with PM2
   - Set webhook for production

### PM2 Configuration

```bash
# Install PM2
npm install -g pm2

# Start backend
cd backend
pm2 start src/server.js --name cashpulse-backend

# Start telegram bot
cd telegram-bot
pm2 start src/bot.js --name cashpulse-bot

# Save PM2 configuration
pm2 save
pm2 startup
```

---

## 🧪 Testing

```bash
# Run backend tests
cd backend
npm test

# Run frontend tests
cd frontend
npm test

# Run integration tests
npm run test:integration
```

---

## 📝 Database Seeding

```bash
# Seed initial data (admin user, investment plans, etc.)
cd backend
npm run seed

# Reset database (CAUTION: Deletes all data)
npm run db:reset
```

---

## 🔧 Maintenance

### Backup Database

```bash
# Backup MongoDB
mongodump --uri="mongodb://localhost:27017/cashpulse" --out=/backup/$(date +%Y%m%d)

# Restore MongoDB
mongorestore --uri="mongodb://localhost:27017/cashpulse" /backup/20231209
```

### Monitor Logs

```bash
# Backend logs
pm2 logs cashpulse-backend

# Bot logs
pm2 logs cashpulse-bot

# System logs
tail -f /var/log/nginx/cashpulse-error.log
```

---

## 📞 Support

- **Email:** blessedsuccess538@gmail.com
- **WhatsApp:** [+2348085430370](https://wa.me/2348085430370)
- **Telegram:** [@alo_ne7217](https://t.me/alo_ne7217)
- **Channel:** [Join our community](https://t.me/makingonline217)

---

## 📄 License

Copyright © 2024 CashPulse. All rights reserved.

---

## 🙏 Acknowledgments

Built with modern technologies for a seamless user experience. Thank you for choosing CashPulse!

---

**🌟 Start earning with CashPulse today!**
