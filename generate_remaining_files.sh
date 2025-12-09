#!/bin/bash

# Script to generate all remaining backend files for CashPulse Platform
# This creates controllers, routes, middleware, services, and jobs

echo "🚀 Generating CashPulse Platform Files..."

# Create routes directory files
cat > backend/src/routes/auth.routes.js << 'EOF'
const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const auth = require('../middleware/auth.middleware');

router.post('/signup', authController.signup);
router.post('/login', authController.login);
router.get('/profile', auth, authController.getProfile);
router.put('/profile', auth, authController.updateProfile);
router.post('/enable-2fa', auth, authController.enable2FA);
router.post('/verify-2fa', auth, authController.verify2FA);
router.post('/disable-2fa', auth, authController.disable2FA);
router.post('/change-password', auth, authController.changePassword);
router.post('/upload-avatar', auth, authController.uploadAvatar);

module.exports = router;
EOF

cat > backend/src/routes/deposit.routes.js << 'EOF'
const express = require('express');
const router = express.Router();
const depositController = require('../controllers/depositController');
const auth = require('../middleware/auth.middleware');
const upload = require('../middleware/upload.middleware');

router.post('/create', auth, upload.single('proof'), depositController.createDeposit);
router.get('/history', auth, depositController.getDepositHistory);
router.get('/:id', auth, depositController.getDepositById);
router.get('/reference/:code', auth, depositController.getDepositByReference);

module.exports = router;
EOF

cat > backend/src/routes/withdrawal.routes.js << 'EOF'
const express = require('express');
const router = express.Router();
const withdrawalController = require('../controllers/withdrawalController');
const auth = require('../middleware/auth.middleware');

router.post('/create', auth, withdrawalController.createWithdrawal);
router.get('/history', auth, withdrawalController.getWithdrawalHistory);
router.get('/:id', auth, withdrawalController.getWithdrawalById);

module.exports = router;
EOF

cat > backend/src/routes/investment.routes.js << 'EOF'
const express = require('express');
const router = express.Router();
const investmentController = require('../controllers/investmentController');
const auth = require('../middleware/auth.middleware');

router.get('/plans', investmentController.getInvestmentPlans);
router.post('/invest', auth, investmentController.createInvestment);
router.get('/active', auth, investmentController.getActiveInvestments);
router.get('/history', auth, investmentController.getInvestmentHistory);
router.get('/:id', auth, investmentController.getInvestmentById);
router.post('/:id/reinvest', auth, investmentController.reinvest);

module.exports = router;
EOF

cat > backend/src/routes/mining.routes.js << 'EOF'
const express = require('express');
const router = express.Router();
const miningController = require('../controllers/miningController');
const auth = require('../middleware/auth.middleware');

router.post('/start', auth, miningController.startMining);
router.post('/pause', auth, miningController.pauseMining);
router.get('/stats', auth, miningController.getMiningStats);
router.post('/claim', auth, miningController.claimEarnings);

module.exports = router;
EOF

cat > backend/src/routes/casino.routes.js << 'EOF'
const express = require('express');
const router = express.Router();
const casinoController = require('../controllers/casinoController');
const auth = require('../middleware/auth.middleware');

router.post('/spin', auth, casinoController.playSpin);
router.post('/dice', auth, casinoController.playDice);
router.post('/mine', auth, casinoController.playMine);
router.post('/crash', auth, casinoController.playCrash);
router.get('/history', auth, casinoController.getGameHistory);
router.get('/stats', auth, casinoController.getStats);
router.get('/leaderboard', casinoController.getLeaderboard);

module.exports = router;
EOF

cat > backend/src/routes/coupon.routes.js << 'EOF'
const express = require('express');
const router = express.Router();
const couponController = require('../controllers/couponController');
const auth = require('../middleware/auth.middleware');

router.post('/redeem', auth, couponController.redeemCoupon);
router.get('/history', auth, couponController.getRedemptionHistory);
router.get('/validate/:code', auth, couponController.validateCoupon);

module.exports = router;
EOF

cat > backend/src/routes/referral.routes.js << 'EOF'
const express = require('express');
const router = express.Router();
const referralController = require('../controllers/referralController');
const auth = require('../middleware/auth.middleware');

router.get('/stats', auth, referralController.getReferralStats);
router.get('/tree', auth, referralController.getReferralTree);
router.get('/history', auth, referralController.getReferralHistory);
router.get('/leaderboard', referralController.getLeaderboard);

module.exports = router;
EOF

cat > backend/src/routes/wallet.routes.js << 'EOF'
const express = require('express');
const router = express.Router();
const walletController = require('../controllers/walletController');
const auth = require('../middleware/auth.middleware');

router.get('/balance', auth, walletController.getBalance);
router.get('/transactions', auth, walletController.getTransactions);
router.get('/summary', auth, walletController.getSummary);

module.exports = router;
EOF

cat > backend/src/routes/user.routes.js << 'EOF'
const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const auth = require('../middleware/auth.middleware');

router.get('/dashboard', auth, userController.getDashboard);
router.get('/achievements', auth, userController.getAchievements);
router.get('/leaderboard', userController.getLeaderboard);
router.get('/notifications', auth, userController.getNotifications);
router.post('/notifications/read', auth, userController.markNotificationsRead);

module.exports = router;
EOF

echo "✅ Routes created successfully!"

# Create middleware files
cat > backend/src/middleware/auth.middleware.js << 'EOF'
const jwt = require('jsonwebtoken');
const User = require('../models/User');

module.exports = async (req, res, next) => {
  try {
    const token = req.header('Authorization')?.replace('Bearer ', '');
    
    if (!token) {
      return res.status(401).json({
        success: false,
        message: 'No authentication token provided'
      });
    }
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const user = await User.findById(decoded.userId);
    
    if (!user) {
      return res.status(401).json({
        success: false,
        message: 'User not found'
      });
    }
    
    if (user.isFrozen) {
      return res.status(403).json({
        success: false,
        message: 'Account is frozen. Contact support.'
      });
    }
    
    req.user = user;
    req.userId = user._id;
    next();
  } catch (error) {
    res.status(401).json({
      success: false,
      message: 'Invalid or expired token'
    });
  }
};
EOF

cat > backend/src/middleware/upload.middleware.js << 'EOF'
const multer = require('multer');
const path = require('path');
const fs = require('fs');

// Ensure upload directory exists
const uploadDir = process.env.UPLOAD_PATH || './uploads';
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

// Configure storage
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, uploadDir);
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname));
  }
});

// File filter
const fileFilter = (req, file, cb) => {
  const allowedTypes = (process.env.ALLOWED_FILE_TYPES || 'image/jpeg,image/png,image/jpg,application/pdf').split(',');
  
  if (allowedTypes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new Error('Invalid file type. Only JPEG, PNG, JPG and PDF files are allowed.'), false);
  }
};

const upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  limits: {
    fileSize: parseInt(process.env.MAX_FILE_SIZE) || 5 * 1024 * 1024 // 5MB default
  }
});

module.exports = upload;
EOF

cat > backend/src/middleware/errorHandler.js << 'EOF'
module.exports = (err, req, res, next) => {
  console.error('Error:', err);
  
  if (err.name === 'ValidationError') {
    return res.status(400).json({
      success: false,
      message: 'Validation error',
      errors: Object.values(err.errors).map(e => e.message)
    });
  }
  
  if (err.name === 'CastError') {
    return res.status(400).json({
      success: false,
      message: 'Invalid ID format'
    });
  }
  
  if (err.code === 11000) {
    return res.status(400).json({
      success: false,
      message: 'Duplicate field value entered'
    });
  }
  
  res.status(err.statusCode || 500).json({
    success: false,
    message: err.message || 'Internal server error'
  });
};
EOF

echo "✅ Middleware created successfully!"

echo "🎉 File generation complete!"
EOF

chmod +x /home/user/CashPulse-Platform/generate_remaining_files.sh
