# 🚀 Deploy CashPulse to Netlify - Complete Guide

## 📋 Overview

This guide will help you deploy the **CashPulse Frontend** to Netlify. For the backend, you'll need to deploy it separately (see Backend Deployment section below).

---

## 🎯 What We're Deploying

### Netlify Deployment:
- ✅ **Frontend (React + Vite)** → Netlify
- ❌ **Backend (Node.js + Express)** → Needs separate hosting
- ❌ **Telegram Bot** → Needs separate hosting

**Note:** Netlify is primarily for static sites and frontends. For the full platform, you'll need to deploy the backend elsewhere.

---

## 🚀 Method 1: Deploy Frontend via Netlify CLI (Recommended)

### Step 1: Install Netlify CLI

```bash
npm install -g netlify-cli
```

### Step 2: Login to Netlify

```bash
netlify login
```

This will open your browser for authentication.

### Step 3: Initialize Netlify in Your Project

```bash
cd CashPulse-Platform/frontend
netlify init
```

Follow the prompts:
- **Create & configure a new site**
- Choose your team
- Site name: `cashpulse` (or your preferred name)
- Build command: `npm run build`
- Publish directory: `dist`

### Step 4: Configure Environment Variables

```bash
# Set environment variables
netlify env:set VITE_API_URL "https://your-backend-url.com/api"
netlify env:set VITE_SOCKET_URL "https://your-backend-url.com"
netlify env:set VITE_PLATFORM_NAME "CashPulse"
netlify env:set VITE_SUPPORT_EMAIL "blessedsuccess538@gmail.com"
netlify env:set VITE_WHATSAPP_URL "https://wa.me/2348085430370"
netlify env:set VITE_TELEGRAM_CHANNEL "https://t.me/makingonline217"
netlify env:set VITE_ADMIN_USERNAME "@alo_ne7217"
```

### Step 5: Deploy

```bash
# Deploy to production
netlify deploy --prod
```

Your site will be live at: `https://your-site-name.netlify.app`

---

## 🚀 Method 2: Deploy via Netlify Web Interface

### Step 1: Push to GitHub

```bash
cd CashPulse-Platform
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/yourusername/cashpulse.git
git push -u origin main
```

### Step 2: Connect to Netlify

1. Go to [Netlify](https://app.netlify.com/)
2. Click **"Add new site"** → **"Import an existing project"**
3. Choose **GitHub** and select your repository
4. Configure build settings:

```
Base directory: frontend
Build command: npm run build
Publish directory: frontend/dist
```

### Step 3: Set Environment Variables

In Netlify Dashboard:
1. Go to **Site settings** → **Environment variables**
2. Add these variables:

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

Click **"Deploy site"** - Netlify will automatically build and deploy!

---

## 🚀 Method 3: Deploy with Netlify Drop

### Quick Deploy (No Git Required)

1. Build your frontend locally:
```bash
cd CashPulse-Platform/frontend
npm install
npm run build
```

2. Go to [Netlify Drop](https://app.netlify.com/drop)
3. Drag and drop the `dist` folder
4. Your site is live instantly!

**Note:** This method doesn't support environment variables easily. Use for testing only.

---

## ⚙️ Configuration Files Included

### `frontend/netlify.toml`
Already configured with:
- Build command
- Publish directory
- SPA redirects
- Security headers
- Cache control

### Custom Domain Setup

1. In Netlify Dashboard → **Domain settings**
2. Click **"Add custom domain"**
3. Enter your domain (e.g., `cashpulse.com`)
4. Follow DNS configuration instructions
5. Netlify will auto-provision SSL certificate

---

## 🔧 Backend Deployment Options

Since Netlify is for frontends, deploy your backend to:

### Option 1: Render.com (Recommended - Free Tier)

```bash
# 1. Push backend to GitHub
# 2. Go to https://render.com
# 3. New → Web Service
# 4. Connect GitHub repo
# 5. Configure:
#    - Build Command: npm install
#    - Start Command: npm start
#    - Environment: Node
# 6. Add environment variables (see backend/.env.example)
```

### Option 2: Railway.app (Easy, Good Free Tier)

```bash
# 1. Install Railway CLI
npm install -g @railway/cli

# 2. Login
railway login

# 3. Deploy backend
cd backend
railway init
railway up
```

### Option 3: Vercel (Serverless)

```bash
# Deploy backend to Vercel
cd backend
vercel

# Or use Vercel dashboard - see DEPLOYMENT_VERCEL.md
```

### Option 4: Heroku

```bash
# 1. Install Heroku CLI
# 2. Login
heroku login

# 3. Create app
cd backend
heroku create cashpulse-backend

# 4. Add MongoDB Atlas
heroku addons:create mongolab

# 5. Deploy
git push heroku main
```

---

## 🗄️ Database Setup (MongoDB Atlas)

### Step 1: Create MongoDB Atlas Account

1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Sign up for free account
3. Create a new cluster (Free tier available)

### Step 2: Configure Database

1. Click **"Connect"**
2. Choose **"Connect your application"**
3. Copy connection string
4. Replace `<password>` with your database password
5. Add to backend environment variables:

```
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/cashpulse?retryWrites=true&w=majority
```

### Step 3: Whitelist IP Addresses

1. In Atlas → **Network Access**
2. Click **"Add IP Address"**
3. Select **"Allow access from anywhere"** (for cloud deployments)
4. Or add your server's specific IP

---

## 📱 Telegram Bot Deployment

Deploy the bot alongside your backend or separately:

### Option 1: With Backend on Render/Railway

The bot will run automatically if included in your backend deployment.

### Option 2: Separate Deployment on Railway

```bash
cd telegram-bot
railway init
railway up

# Set environment variables on Railway dashboard
```

### Option 3: Keep Running Locally

If you have a local server or VPS, keep the bot running there:

```bash
cd telegram-bot
npm start

# Use PM2 for persistent running
pm2 start src/bot.js --name cashpulse-bot
pm2 save
pm2 startup
```

---

## 🔐 Environment Variables Checklist

### Frontend (Netlify):
- ✅ `VITE_API_URL` - Your backend URL
- ✅ `VITE_SOCKET_URL` - Your backend URL
- ✅ `VITE_PLATFORM_NAME` - CashPulse
- ✅ `VITE_SUPPORT_EMAIL` - blessedsuccess538@gmail.com
- ✅ `VITE_WHATSAPP_URL` - https://wa.me/2348085430370
- ✅ `VITE_TELEGRAM_CHANNEL` - https://t.me/makingonline217

### Backend (Render/Railway/etc):
- ⚠️ `MONGODB_URI` - Your MongoDB Atlas connection string
- ⚠️ `JWT_SECRET` - Strong random string (50+ characters)
- ⚠️ `FRONTEND_URL` - Your Netlify frontend URL
- ✅ `TELEGRAM_BOT_TOKEN` - 7572708038:AAEIhWwcSDk1lC489N6C6hz2ohudhPHTEGM
- ✅ `ADMIN_TELEGRAM_ID` - 7590603733
- ✅ All other variables from backend/.env.example

---

## 🎯 Complete Deployment Workflow

### 1. Deploy Database
```bash
# Create MongoDB Atlas cluster
# Get connection string
```

### 2. Deploy Backend
```bash
# Choose Render/Railway/Vercel/Heroku
# Configure environment variables
# Note the backend URL
```

### 3. Deploy Frontend
```bash
# Update VITE_API_URL with backend URL
# Deploy to Netlify
```

### 4. Deploy Bot
```bash
# Deploy with backend or separately
# Verify bot responds to /start
```

### 5. Test Everything
```bash
# Visit frontend URL
# Test user signup
# Test deposit submission
# Approve via Telegram bot
# Test all features
```

---

## 🔍 Troubleshooting

### Build Fails on Netlify

**Error:** "Failed to load config from vite.config.js"
```bash
# Solution: Ensure vite is in dependencies
cd frontend
npm install vite --save
git commit -am "Add vite to dependencies"
git push
```

### API Requests Failing

**Error:** "Network error" or "CORS error"
```bash
# Solution: Check backend CORS configuration
# In backend/src/server.js, ensure:
app.use(cors({
  origin: 'https://your-netlify-site.netlify.app',
  credentials: true
}));
```

### Environment Variables Not Working

```bash
# Verify variables are set correctly:
netlify env:list

# Or check Netlify Dashboard → Site settings → Environment variables
```

### Site Returns 404 on Refresh

This is normal for SPAs. The `netlify.toml` file should handle this.

If not working, add this to `netlify.toml`:
```toml
[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
```

---

## 🎉 Success Checklist

After deployment, verify:

- [ ] Frontend loads at Netlify URL
- [ ] Can navigate between pages
- [ ] API requests reach backend
- [ ] Socket.IO connects successfully
- [ ] User signup works
- [ ] Deposit submission works
- [ ] Telegram bot receives notifications
- [ ] Admin can approve via bot
- [ ] Custom domain configured (optional)
- [ ] SSL certificate active

---

## 💡 Cost Estimate

### Free Tier (Good for testing):
- **Netlify:** 100GB bandwidth/month (FREE)
- **Render.com:** 750 hours/month (FREE)
- **MongoDB Atlas:** 512MB storage (FREE)
- **Total:** $0/month

### Paid Tier (For production):
- **Netlify Pro:** $19/month (custom domain, more bandwidth)
- **Render.com:** $7/month (always-on backend)
- **MongoDB Atlas:** $9/month (2GB storage, backups)
- **Total:** ~$35/month

---

## 📞 Support

Need help with deployment?

- **Email:** blessedsuccess538@gmail.com
- **WhatsApp:** [+2348085430370](https://wa.me/2348085430370)
- **Telegram:** [@alo_ne7217](https://t.me/alo_ne7217)

---

## 🎊 You're Live!

Once deployed, your platform will be accessible at:
- **Frontend:** `https://your-site-name.netlify.app`
- **Backend:** `https://your-backend-url.onrender.com` (or other host)

Share your platform and start earning! 🚀💰

---

**Next Steps:**
- Test all features thoroughly
- Complete frontend UI development
- Add your custom domain
- Setup monitoring and analytics
- Promote to users!
