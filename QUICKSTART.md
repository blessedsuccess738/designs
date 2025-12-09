# 🚀 CashPulse Quick Start Guide

## 📦 What's Included

This package contains a complete, production-ready Naira investment and earning platform with:

✅ **Backend API** (Node.js + Express + MongoDB)
✅ **Frontend Web App** (React + Vite + Tailwind)
✅ **Telegram Admin Bot** (Complete platform control)
✅ **7 Investment Plans** (₦3,000 - ₦500,000)
✅ **Mining System** (₦25/minute passive income)
✅ **4 Casino Games** (Spin, Dice, Mine, Crash)
✅ **Referral System** (₦200 per referral)
✅ **Daily Coupons** (Admin-generated)
✅ **Gamification** (Achievements, badges, leaderboards)
✅ **Real-time Updates** (Socket.IO)
✅ **Security Features** (2FA, JWT, rate limiting)

---

## ⚡ 5-Minute Setup

### Step 1: Install Dependencies

```bash
# Install Node.js 18+ from https://nodejs.org
# Install MongoDB from https://www.mongodb.com/try/download/community

# Navigate to project
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

### Step 2: Configure Environment

```bash
# Backend configuration
cd backend
cp .env.example .env

# Edit .env with your preferred text editor
# The file already contains your Telegram credentials
nano .env  # or use vim, code, notepad++, etc.
```

**Critical Environment Variables** (Already configured with your details):
- ✅ `TELEGRAM_BOT_TOKEN` = 7572708038:AAEIhWwcSDk1lC489N6C6hz2ohudhPHTEGM
- ✅ `ADMIN_TELEGRAM_ID` = 7590603733
- ✅ `ADMIN_USERNAME` = @alo_ne7217
- ✅ `PLATFORM_NAME` = CashPulse
- ⚠️ `MONGODB_URI` = Change if not using local MongoDB
- ⚠️ `JWT_SECRET` = **MUST CHANGE** for security

### Step 3: Start MongoDB

```bash
# Windows (in Command Prompt)
"C:\Program Files\MongoDB\Server\6.0\bin\mongod.exe"

# macOS (using Homebrew)
brew services start mongodb-community

# Linux (using systemd)
sudo systemctl start mongod

# Or use MongoDB Atlas (cloud):
# Update MONGODB_URI in .env with your Atlas connection string
```

### Step 4: Seed Database (Optional but Recommended)

```bash
cd backend
npm run seed
# This creates:
# - All 7 investment plans
# - Sample test data
# - Admin user (if needed)
```

### Step 5: Start All Services

**Terminal 1 - Backend:**
```bash
cd backend
npm run dev
```

**Terminal 2 - Frontend:**
```bash
cd frontend
npm run dev
```

**Terminal 3 - Telegram Bot:**
```bash
cd telegram-bot
npm start
```

### Step 6: Access Your Platform

- 🌐 **Frontend:** http://localhost:5173
- 🔌 **Backend API:** http://localhost:5000
- 📊 **Health Check:** http://localhost:5000/health
- 🤖 **Telegram Bot:** Send `/start` to your bot

---

## 🎮 Testing the Platform

### 1. Create a Test User

Visit http://localhost:5173 and click "Sign Up":
- Full Name: Test User
- Email: test@cashpulse.com
- Phone: +2348012345678
- Password: test123456

### 2. Make a Test Deposit

1. Navigate to "Deposit" section
2. Enter amount: ₦5000
3. Upload any image as proof
4. Submit request

### 3. Approve Deposit (Telegram)

Open your Telegram bot and:
```
/deposits_pending
# You'll see the new deposit
/approve_deposit DEP...  (use the reference code shown)
```

### 4. Start Investing

- Go to "Investments" section
- Choose a plan (e.g., Basic Plan - ₦5,000)
- Click "Invest Now"
- Watch daily returns accumulate!

### 5. Try Mining

- Go to "Mining" section
- Click "Start Mining"
- Watch earnings increase (₦25/minute)

### 6. Play Casino Games

- Go to "Casino" section
- Choose a game (Spin, Dice, Mine, Crash)
- Place a stake
- Win multipliers!

---

## 🤖 Telegram Bot Commands

### User Management
```
/new_users - List recent signups
/user_balance <user_id> - Check user balance
/freeze_account <user_id> - Freeze account
/unfreeze_account <user_id> - Unfreeze account
```

### Deposits & Withdrawals
```
/deposits_pending - List pending deposits
/approve_deposit <reference_code> - Approve deposit
/reject_deposit <reference_code> - Reject deposit

/withdrawals_pending - List pending withdrawals
/approve_withdrawal <withdrawal_id> - Approve withdrawal
/reject_withdrawal <withdrawal_id> - Reject withdrawal
```

### Coupons
```
/generate_coupon <amount> <quantity> - Generate coupons
Example: /generate_coupon 1000 50

/list_coupons - Show all active coupons
/delete_coupon <coupon_code> - Delete a coupon
```

### Notifications
```
/notify <user_id> <message> - Send message to specific user
/notify_all <message> - Broadcast to all users
```

### Analytics
```
/platform_stats - Get platform statistics
/leaderboard - Show top users
/daily_report - Get daily activity report
```

---

## 📁 Project Structure

```
CashPulse-Platform/
├── backend/               # Node.js API server
│   ├── src/
│   │   ├── config/       # Database, Telegram config
│   │   ├── models/       # MongoDB models
│   │   ├── controllers/  # Business logic
│   │   ├── routes/       # API endpoints
│   │   ├── middleware/   # Auth, validation
│   │   ├── services/     # External services
│   │   ├── jobs/         # Cron jobs
│   │   └── server.js     # Entry point
│   ├── uploads/          # User file uploads
│   └── package.json
│
├── frontend/             # React web app
│   ├── src/
│   │   ├── components/   # UI components
│   │   ├── pages/        # App pages
│   │   ├── services/     # API calls
│   │   ├── store/        # Redux store
│   │   └── App.jsx
│   └── package.json
│
├── telegram-bot/         # Admin bot
│   ├── src/
│   │   ├── bot.js        # Bot logic
│   │   └── commands/     # Bot commands
│   └── package.json
│
└── docs/                 # Documentation
```

---

## 🔧 Troubleshooting

### MongoDB Connection Failed
```
Error: MongooseServerSelectionError
```
**Solution:** Ensure MongoDB is running:
```bash
# Check if MongoDB is running
sudo systemctl status mongod  # Linux
brew services list  # macOS

# Start MongoDB
sudo systemctl start mongod  # Linux
brew services start mongodb-community  # macOS
```

### Telegram Bot Not Responding
```
Error: 401 Unauthorized
```
**Solution:** Verify bot token in `.env`:
```bash
cd backend
grep TELEGRAM_BOT_TOKEN .env
# Should show: TELEGRAM_BOT_TOKEN=7572708038:AAEIhWwcSDk1lC489N6C6hz2ohudhPHTEGM
```

### Port Already in Use
```
Error: listen EADDRINUSE: address already in use :::5000
```
**Solution:** Change port or kill existing process:
```bash
# Option 1: Change PORT in .env
PORT=5001

# Option 2: Kill process
# Linux/macOS
lsof -ti:5000 | xargs kill -9
# Windows
netstat -ano | findstr :5000
taskkill /PID <PID> /F
```

### Frontend Can't Connect to Backend
**Solution:** Check CORS settings in `backend/src/server.js` and `frontend/.env`:
```
# frontend/.env
VITE_API_URL=http://localhost:5000/api
```

---

## 🚀 Deployment to Production

### Option 1: VPS Deployment (Recommended)

#### Requirements
- Ubuntu 20.04+ VPS
- Domain name (e.g., cashpulse.com)
- SSL certificate (Let's Encrypt)

#### Steps

1. **Setup Server**
```bash
# SSH into your VPS
ssh root@your-server-ip

# Update system
apt update && apt upgrade -y

# Install Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
apt install -y nodejs

# Install MongoDB
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list
apt update
apt install -y mongodb-org
systemctl start mongod
systemctl enable mongod

# Install PM2
npm install -g pm2

# Install Nginx
apt install -y nginx certbot python3-certbot-nginx
```

2. **Upload Code**
```bash
# On your local machine
cd CashPulse-Platform
tar -czf cashpulse.tar.gz .
scp cashpulse.tar.gz root@your-server-ip:/root/

# On server
cd /root
tar -xzf cashpulse.tar.gz
cd CashPulse-Platform
```

3. **Install Dependencies**
```bash
cd backend && npm install --production
cd ../frontend && npm install && npm run build
cd ../telegram-bot && npm install --production
```

4. **Configure Environment**
```bash
cd /root/CashPulse-Platform/backend
nano .env

# Update these values:
NODE_ENV=production
MONGODB_URI=mongodb://localhost:27017/cashpulse
FRONTEND_URL=https://yourdomain.com
JWT_SECRET=<generate-strong-random-string>
```

5. **Start Services with PM2**
```bash
cd /root/CashPulse-Platform

# Start backend
cd backend
pm2 start src/server.js --name cashpulse-backend

# Start telegram bot
cd ../telegram-bot
pm2 start src/bot.js --name cashpulse-bot

# Save PM2 config
pm2 save
pm2 startup
```

6. **Configure Nginx**
```bash
nano /etc/nginx/sites-available/cashpulse

# Paste this configuration:
```
```nginx
# Backend API
server {
    listen 80;
    server_name api.yourdomain.com;
    
    location / {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}

# Frontend
server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;
    root /root/CashPulse-Platform/frontend/dist;
    index index.html;
    
    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

```bash
# Enable site
ln -s /etc/nginx/sites-available/cashpulse /etc/nginx/sites-enabled/
nginx -t
systemctl reload nginx

# Get SSL certificate
certbot --nginx -d yourdomain.com -d www.yourdomain.com -d api.yourdomain.com
```

7. **Setup Firewall**
```bash
ufw allow 22
ufw allow 80
ufw allow 443
ufw enable
```

### Option 2: Heroku Deployment

See `docs/DEPLOYMENT_GUIDE.md` for Heroku, AWS, and other platforms.

---

## 📊 Investment Plans Summary

| Plan | Amount | Daily Return | Total Return (30 days) |
|------|--------|--------------|----------------------|
| Starter | ₦3,000 | ₦1,200 (40%) | ₦36,000 |
| Basic | ₦5,000 | ₦2,000 (40%) | ₦60,000 |
| Silver | ₦10,000 | ₦4,000 (40%) | ₦120,000 |
| Gold | ₦50,000 | ₦20,000 (40%) | ₦600,000 |
| Platinum | ₦100,000 | ₦40,000 (40%) | ₦1,200,000 |
| Diamond | ₦250,000 | ₦100,000 (40%) | ₦3,000,000 |
| Elite | ₦500,000 | ₦200,000 (40%) | ₦6,000,000 |

---

## 💡 Tips for Success

1. **Test Everything** - Use test accounts before going live
2. **Monitor Telegram** - All important notifications go there
3. **Backup Database** - Schedule daily MongoDB backups
4. **Secure JWT Secret** - Use a strong random string (50+ characters)
5. **Enable HTTPS** - Always use SSL in production
6. **Monitor Resources** - Use PM2 monitoring: `pm2 monit`
7. **Log Rotation** - Setup log rotation to prevent disk space issues
8. **Rate Limiting** - Already configured, adjust if needed
9. **Regular Updates** - Keep dependencies updated

---

## 📞 Support & Contact

- **Email:** blessedsuccess538@gmail.com
- **WhatsApp:** [+2348085430370](https://wa.me/2348085430370)
- **Telegram:** [@alo_ne7217](https://t.me/alo_ne7217)
- **Channel:** [Join Community](https://t.me/makingonline217)

---

## 🎉 You're Ready!

Your CashPulse platform is now configured and ready to launch!

**Next Steps:**
1. Complete the 5-minute setup above
2. Test all features thoroughly
3. Customize branding (colors, logos)
4. Deploy to production
5. Promote to users!

**Remember:** This is a complete, production-ready platform. All your credentials are already configured!

🚀 **Good luck with your platform!**
