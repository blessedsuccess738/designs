# 🚀 Deploy CashPulse to Vercel - Complete Guide

## 📋 Overview

This guide covers deploying the **complete CashPulse Platform** to Vercel, including frontend, backend API, and configuration.

---

## 🎯 What We're Deploying

### Vercel Deployment Options:

**Option 1: Frontend Only**
- ✅ **Frontend (React + Vite)** → Vercel
- ❌ **Backend** → Deploy elsewhere (Render, Railway)
- ❌ **Telegram Bot** → Deploy elsewhere

**Option 2: Full Stack (Advanced)**
- ✅ **Frontend** → Vercel
- ✅ **Backend** → Vercel Serverless Functions
- ⚠️ **Telegram Bot** → Needs modifications for serverless

**This guide covers both options!**

---

## 🚀 Method 1: Deploy Frontend Only (Recommended)

### Step 1: Install Vercel CLI

```bash
npm install -g vercel
```

### Step 2: Login to Vercel

```bash
vercel login
```

### Step 3: Deploy Frontend

```bash
cd CashPulse-Platform/frontend
vercel

# Follow prompts:
# - Set up and deploy? Yes
# - Which scope? Your account
# - Link to existing project? No
# - Project name: cashpulse
# - Directory: ./ (current directory)
# - Override settings? No
```

### Step 4: Configure Environment Variables

```bash
# Production environment variables
vercel env add VITE_API_URL production
# Enter: https://your-backend-url.com/api

vercel env add VITE_SOCKET_URL production
# Enter: https://your-backend-url.com

vercel env add VITE_PLATFORM_NAME production
# Enter: CashPulse

vercel env add VITE_SUPPORT_EMAIL production
# Enter: blessedsuccess538@gmail.com

vercel env add VITE_WHATSAPP_URL production
# Enter: https://wa.me/2348085430370

vercel env add VITE_TELEGRAM_CHANNEL production
# Enter: https://t.me/makingonline217

vercel env add VITE_ADMIN_USERNAME production
# Enter: @alo_ne7217
```

### Step 5: Deploy to Production

```bash
vercel --prod
```

Your frontend will be live at: `https://cashpulse.vercel.app`

---

## 🚀 Method 2: Deploy via Vercel Dashboard

### Step 1: Push to GitHub

```bash
cd CashPulse-Platform
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/yourusername/cashpulse.git
git push -u origin main
```

### Step 2: Import to Vercel

1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Click **"Add New"** → **"Project"**
3. Import your GitHub repository
4. Configure:

```
Framework Preset: Vite
Root Directory: frontend
Build Command: npm run build
Output Directory: dist
Install Command: npm install
```

### Step 3: Environment Variables

Add these in the **Environment Variables** section:

```
VITE_API_URL = https://your-backend-url.com/api
VITE_SOCKET_URL = https://your-backend-url.com
VITE_PLATFORM_NAME = CashPulse
VITE_SUPPORT_EMAIL = blessedsuccess538@gmail.com
VITE_WHATSAPP_URL = https://wa.me/2348085430370
VITE_TELEGRAM_CHANNEL = https://t.me/makingonline217
VITE_ADMIN_USERNAME = @alo_ne7217
```

### Step 4: Deploy

Click **"Deploy"** - Vercel will build and deploy automatically!

---

## 🚀 Method 3: Deploy Full Stack on Vercel (Advanced)

### Overview

Deploy both frontend and backend on Vercel using serverless functions.

**Note:** This requires modifying the backend for serverless compatibility.

### Step 1: Project Structure

Create this structure:
```
CashPulse-Platform/
├── api/              # Backend as serverless functions
│   └── [...all backend files]
├── frontend/         # Frontend (stays the same)
└── vercel.json       # Root configuration
```

### Step 2: Modify Backend for Vercel Serverless

Create `api/index.js`:

```javascript
// api/index.js - Main serverless function
const app = require('../backend/src/server').app;

module.exports = app;
```

### Step 3: Root `vercel.json`

```json
{
  "version": 2,
  "name": "cashpulse-fullstack",
  "builds": [
    {
      "src": "frontend/package.json",
      "use": "@vercel/static-build",
      "config": {
        "distDir": "dist"
      }
    },
    {
      "src": "api/**/*.js",
      "use": "@vercel/node"
    }
  ],
  "routes": [
    {
      "src": "/api/(.*)",
      "dest": "/api/$1"
    },
    {
      "src": "/(.*)",
      "dest": "/frontend/$1"
    }
  ]
}
```

### Step 4: Deploy

```bash
vercel --prod
```

**Important Limitations:**
- Serverless functions have 10-second timeout
- No persistent WebSocket connections
- Cron jobs won't work (use external cron services)
- File uploads need cloud storage (S3, Cloudinary)

**Recommendation:** Deploy frontend on Vercel, backend elsewhere for better performance.

---

## 🔧 Backend Deployment Recommendations

For best results, deploy backend separately:

### Option 1: Render.com (Recommended)

```bash
# 1. Go to https://render.com
# 2. New → Web Service
# 3. Connect GitHub repository
# 4. Configure:
#    Name: cashpulse-backend
#    Environment: Node
#    Build Command: npm install
#    Start Command: npm start
#    Region: Choose closest to users

# 5. Environment Variables (copy from backend/.env.example):
MONGODB_URI = mongodb+srv://...
JWT_SECRET = your-super-secret-key
FRONTEND_URL = https://cashpulse.vercel.app
TELEGRAM_BOT_TOKEN = 7572708038:AAEIhWwcSDk1lC489N6C6hz2ohudhPHTEGM
ADMIN_TELEGRAM_ID = 7590603733
# ... add all other variables

# 6. Deploy!
```

**Render Benefits:**
- ✅ Always-on servers (unlike serverless)
- ✅ Free tier available (750 hours/month)
- ✅ Automatic deploys from Git
- ✅ Built-in SSL
- ✅ Health checks
- ✅ Easy scaling

### Option 2: Railway.app

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Deploy backend
cd backend
railway init
railway up

# Add environment variables via dashboard
railway open
```

**Railway Benefits:**
- ✅ $5 free credit monthly
- ✅ Very simple deployment
- ✅ Built-in databases
- ✅ Great for Node.js

### Option 3: Heroku

```bash
# Install Heroku CLI
# Login
heroku login

# Create app
cd backend
heroku create cashpulse-backend

# Add MongoDB
heroku addons:create mongolab

# Configure environment variables
heroku config:set JWT_SECRET="your-secret"
heroku config:set TELEGRAM_BOT_TOKEN="7572708038:AAEIhWwcSDk1lC489N6C6hz2ohudhPHTEGM"
# ... set all variables

# Deploy
git push heroku main
```

---

## 🗄️ Database Setup (MongoDB Atlas)

### Step 1: Create Cluster

1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Create account (free tier available)
3. Create cluster:
   - Cloud Provider: AWS/GCP/Azure
   - Region: Choose closest to your backend
   - Cluster Tier: M0 Sandbox (FREE)

### Step 2: Create Database User

1. Database Access → Add New User
2. Username: `cashpulse`
3. Password: Generate secure password
4. Database User Privileges: Read and write to any database

### Step 3: Whitelist IP Addresses

1. Network Access → Add IP Address
2. **Allow access from anywhere:** `0.0.0.0/0`
3. Or add specific IPs of your hosting providers

### Step 4: Get Connection String

1. Click **"Connect"**
2. Choose **"Connect your application"**
3. Copy connection string:
```
mongodb+srv://cashpulse:<password>@cluster0.xxxxx.mongodb.net/cashpulse?retryWrites=true&w=majority
```

4. Replace `<password>` with your actual password
5. Add to backend environment variables as `MONGODB_URI`

---

## 📱 Telegram Bot Deployment

### Option 1: Deploy with Backend (Recommended)

The bot runs automatically when backend starts. Just ensure `telegram-bot/src/bot.js` is required in your backend server.

Add to `backend/src/server.js`:
```javascript
// Start Telegram bot
if (process.env.TELEGRAM_BOT_TOKEN) {
  require('../../telegram-bot/src/bot');
  console.log('✅ Telegram bot started');
}
```

### Option 2: Separate Deployment on Railway

```bash
cd telegram-bot
railway init
railway up

# Set environment variables on Railway dashboard:
# - TELEGRAM_BOT_TOKEN
# - ADMIN_TELEGRAM_ID
# - API_BASE_URL (your backend URL)
```

### Option 3: VPS/Local Server

Keep the bot running on a server with PM2:

```bash
cd telegram-bot
npm install
pm2 start src/bot.js --name cashpulse-bot
pm2 save
pm2 startup
```

---

## 🔐 Environment Variables Complete List

### Frontend (Vercel):
```bash
VITE_API_URL=https://your-backend.onrender.com/api
VITE_SOCKET_URL=https://your-backend.onrender.com
VITE_PLATFORM_NAME=CashPulse
VITE_SUPPORT_EMAIL=blessedsuccess538@gmail.com
VITE_WHATSAPP_URL=https://wa.me/2348085430370
VITE_TELEGRAM_CHANNEL=https://t.me/makingonline217
VITE_ADMIN_USERNAME=@alo_ne7217
```

### Backend (Render/Railway/Heroku):
```bash
# CRITICAL - Change these!
MONGODB_URI=mongodb+srv://user:pass@cluster.mongodb.net/cashpulse
JWT_SECRET=your-super-secure-random-50-character-string-here
FRONTEND_URL=https://cashpulse.vercel.app

# Your pre-configured credentials
TELEGRAM_BOT_TOKEN=7572708038:AAEIhWwcSDk1lC489N6C6hz2ohudhPHTEGM
ADMIN_TELEGRAM_ID=7590603733
ADMIN_USERNAME=@alo_ne7217
SUPPORT_EMAIL=blessedsuccess538@gmail.com
WHATSAPP_NUMBER=+2348085430370
WHATSAPP_URL=https://wa.me/2348085430370
TELEGRAM_CHANNEL=https://t.me/makingonline217

# Platform settings
PLATFORM_NAME=CashPulse
PALMPAY_ACCOUNT_NAME=SUCCESS KELECHI BLESSED
PALMPAY_ACCOUNT_NUMBER=8901140537
PALMPAY_BANK_NAME=PalmPay

# System configuration
NODE_ENV=production
PORT=5000
MINING_RATE_PER_MINUTE=25
INVESTMENT_DAILY_RETURN_PERCENTAGE=40
INVESTMENT_CYCLE_DAYS=30
REFERRAL_TIER1_BONUS=200
REFERRAL_TIER2_BONUS=50
MIN_WITHDRAWAL_AMOUNT=3000
```

---

## 🎯 Complete Deployment Workflow

### 1. Setup MongoDB Atlas
```bash
✅ Create cluster
✅ Create database user
✅ Whitelist IPs
✅ Get connection string
```

### 2. Deploy Backend to Render
```bash
✅ Create web service
✅ Connect GitHub repo (backend folder)
✅ Add environment variables
✅ Deploy
✅ Note backend URL
```

### 3. Deploy Frontend to Vercel
```bash
✅ Connect GitHub repo (frontend folder)
✅ Add environment variables (including backend URL)
✅ Deploy
✅ Test frontend loads
```

### 4. Verify Telegram Bot
```bash
✅ Bot should auto-start with backend
✅ Send /start to bot
✅ Test admin commands
```

### 5. Test Complete Flow
```bash
✅ Visit frontend URL
✅ Create test account
✅ Submit test deposit
✅ Approve via Telegram bot
✅ Verify balance updates
✅ Test all features
```

---

## 🔍 Troubleshooting

### Frontend Build Fails

**Error:** "Cannot find module 'vite'"
```bash
cd frontend
npm install
# Ensure package.json has all dependencies
vercel --prod
```

### API Requests Failing

**Error:** "CORS policy error"

Solution - Update backend CORS:
```javascript
// backend/src/server.js
app.use(cors({
  origin: [
    'https://cashpulse.vercel.app',
    'https://cashpulse-yourusername.vercel.app'
  ],
  credentials: true
}));
```

### Environment Variables Not Working

```bash
# List all variables
vercel env ls

# Pull environment variables
vercel env pull

# Re-deploy after adding variables
vercel --prod
```

### MongoDB Connection Failed

Check:
- ✅ Connection string is correct
- ✅ Password doesn't have special characters (URL encode if needed)
- ✅ IP whitelist includes `0.0.0.0/0` or your server's IP
- ✅ Database user has correct permissions

### Telegram Bot Not Responding

Check:
- ✅ `TELEGRAM_BOT_TOKEN` is correct
- ✅ `ADMIN_TELEGRAM_ID` is correct
- ✅ Bot is running (check backend logs)
- ✅ Bot token is valid (not revoked)

---

## 💰 Cost Comparison

### Free Tier (Perfect for Testing):
| Service | Free Tier | Limit |
|---------|-----------|-------|
| Vercel | ✅ Free | 100GB bandwidth, unlimited projects |
| Render | ✅ Free | 750 hours/month, 512MB RAM |
| MongoDB Atlas | ✅ Free | 512MB storage |
| Railway | $5 credit | ~$5/month usage |
| **Total** | **$0-5/month** | Good for 1000+ users |

### Production Tier:
| Service | Cost | Features |
|---------|------|----------|
| Vercel Pro | $20/month | Unlimited bandwidth, analytics |
| Render Starter | $7/month | Always-on, 512MB RAM |
| MongoDB Atlas | $9/month | 2GB storage, backups |
| **Total** | **~$36/month** | Good for 10,000+ users |

---

## 🎨 Custom Domain Setup

### On Vercel (Frontend):

1. Go to Vercel Dashboard → Your Project
2. Settings → Domains
3. Add domain: `cashpulse.com`
4. Add these DNS records:

```
Type: A
Name: @
Value: 76.76.21.21

Type: CNAME
Name: www
Value: cname.vercel-dns.com
```

5. SSL is automatic!

### On Render (Backend):

1. Render Dashboard → Your Service
2. Settings → Custom Domain
3. Add domain: `api.cashpulse.com`
4. Add DNS record:

```
Type: CNAME
Name: api
Value: your-service.onrender.com
```

---

## ✅ Post-Deployment Checklist

After deployment, verify:

- [ ] Frontend loads at Vercel URL
- [ ] Backend responds at /health endpoint
- [ ] Database connection successful
- [ ] User signup works end-to-end
- [ ] Login and JWT tokens work
- [ ] Deposit submission successful
- [ ] Telegram bot receives notification
- [ ] Admin can approve via Telegram
- [ ] Balance updates correctly
- [ ] Investment creation works
- [ ] Mining can be started
- [ ] WebSocket connection established
- [ ] All API endpoints responding
- [ ] Custom domain configured (optional)
- [ ] SSL certificates active

---

## 📊 Monitoring & Analytics

### Vercel Analytics

Enable in dashboard:
1. Project Settings → Analytics
2. Enable Web Analytics
3. View real-time traffic, performance

### Backend Monitoring

Add to Render/Railway dashboard:
1. View logs for errors
2. Monitor CPU/RAM usage
3. Setup alerts for downtime

### Recommended Tools:
- **Sentry** - Error tracking
- **LogRocket** - Session replay
- **Google Analytics** - User analytics

---

## 🚀 Performance Optimization

### Frontend:
```bash
# Enable Vercel Speed Insights
npm install @vercel/speed-insights
```

### Backend:
```javascript
// Add compression
const compression = require('compression');
app.use(compression());

// Add caching headers
app.use((req, res, next) => {
  res.set('Cache-Control', 'public, max-age=3600');
  next();
});
```

### Database:
```javascript
// Add indexes (already done in models)
// Enable connection pooling
mongoose.connect(uri, {
  maxPoolSize: 10,
  serverSelectionTimeoutMS: 5000
});
```

---

## 📞 Support

Need help with Vercel deployment?

- **Email:** blessedsuccess538@gmail.com
- **WhatsApp:** [+2348085430370](https://wa.me/2348085430370)
- **Telegram:** [@alo_ne7217](https://t.me/alo_ne7217)

---

## 🎉 You're Live on Vercel!

Your platform is now accessible at:
- **Frontend:** `https://cashpulse.vercel.app`
- **Backend:** `https://cashpulse-backend.onrender.com`
- **Custom Domain:** `https://cashpulse.com` (if configured)

Share with users and start earning! 🚀💰

---

**Pro Tips:**
- Use Vercel's preview deployments for testing
- Enable automatic deployments from Git
- Setup branch previews for development
- Monitor performance with Vercel Analytics
- Use Vercel Edge Functions for global performance

**Congratulations on your deployment! 🎊**
