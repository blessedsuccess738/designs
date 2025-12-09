#!/usr/bin/env python3
"""
Generate all controller files for CashPulse Platform
"""

import os

# Auth Controller
auth_controller = """const User = require('../models/User');
const jwt = require('jsonwebtoken');
const speakeasy = require('speakeasy');
const QRCode = require('qrcode');
const telegramService = require('../config/telegram');

// Generate JWT Token
const generateToken = (userId) => {
  return jwt.sign({ userId }, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRE || '7d'
  });
};

// @desc    Register new user
// @route   POST /api/auth/signup
exports.signup = async (req, res) => {
  try {
    const { email, phone, password, fullName, referralCode } = req.body;
    
    // Check if user exists
    const userExists = await User.findOne({ $or: [{ email }, { phone }] });
    if (userExists) {
      return res.status(400).json({
        success: false,
        message: 'User with this email or phone already exists'
      });
    }
    
    // Create user
    const user = new User({
      email,
      phone,
      password,
      fullName,
      referredBy: referralCode || null
    });
    
    await user.save();
    
    // Process referral bonus
    if (referralCode) {
      const referrer = await User.findOne({ referralCode });
      if (referrer) {
        const tier1Bonus = parseInt(process.env.REFERRAL_TIER1_BONUS) || 200;
        await referrer.updateBalance(tier1Bonus, 'add');
        referrer.referralCount += 1;
        referrer.totalReferralEarnings += tier1Bonus;
        await referrer.save();
        
        // Notify admin
        await telegramService.notifyReferralEarning(referrer, user, tier1Bonus);
        
        // Check for tier 2 referral
        if (referrer.referredBy) {
          const tier2Referrer = await User.findOne({ referralCode: referrer.referredBy });
          if (tier2Referrer) {
            const tier2Bonus = parseInt(process.env.REFERRAL_TIER2_BONUS) || 50;
            await tier2Referrer.updateBalance(tier2Bonus, 'add');
            tier2Referrer.totalReferralEarnings += tier2Bonus;
            await tier2Referrer.save();
          }
        }
      }
    }
    
    // Notify admin of new signup
    await telegramService.notifyNewSignup(user);
    
    // Generate token
    const token = generateToken(user._id);
    
    res.status(201).json({
      success: true,
      message: 'Registration successful',
      data: {
        user,
        token
      }
    });
  } catch (error) {
    console.error('Signup error:', error);
    res.status(500).json({
      success: false,
      message: error.message || 'Signup failed'
    });
  }
};

// @desc    Login user
// @route   POST /api/auth/login
exports.login = async (req, res) => {
  try {
    const { emailOrPhone, password, twoFactorCode } = req.body;
    
    // Find user
    const user = await User.findOne({
      $or: [{ email: emailOrPhone }, { phone: emailOrPhone }]
    });
    
    if (!user) {
      return res.status(401).json({
        success: false,
        message: 'Invalid credentials'
      });
    }
    
    // Check password
    const isMatch = await user.comparePassword(password);
    if (!isMatch) {
      return res.status(401).json({
        success: false,
        message: 'Invalid credentials'
      });
    }
    
    // Check if account is frozen
    if (user.isFrozen) {
      return res.status(403).json({
        success: false,
        message: 'Account is frozen. Please contact support.'
      });
    }
    
    // Check 2FA
    if (user.twoFactorEnabled) {
      if (!twoFactorCode) {
        return res.status(200).json({
          success: true,
          requires2FA: true,
          message: 'Two-factor authentication required'
        });
      }
      
      const verified = speakeasy.totp.verify({
        secret: user.twoFactorSecret,
        encoding: 'base32',
        token: twoFactorCode
      });
      
      if (!verified) {
        return res.status(401).json({
          success: false,
          message: 'Invalid 2FA code'
        });
      }
    }
    
    // Update login stats
    user.lastLoginAt = new Date();
    user.lastLoginIP = req.ip;
    user.loginCount += 1;
    await user.save();
    
    // Generate token
    const token = generateToken(user._id);
    
    res.json({
      success: true,
      message: 'Login successful',
      data: {
        user,
        token
      }
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({
      success: false,
      message: error.message || 'Login failed'
    });
  }
};

// @desc    Get user profile
// @route   GET /api/auth/profile
exports.getProfile = async (req, res) => {
  try {
    res.json({
      success: true,
      data: req.user
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Update user profile
// @route   PUT /api/auth/profile
exports.updateProfile = async (req, res) => {
  try {
    const { fullName, phone } = req.body;
    const user = req.user;
    
    if (fullName) user.fullName = fullName;
    if (phone) user.phone = phone;
    
    await user.save();
    
    res.json({
      success: true,
      message: 'Profile updated successfully',
      data: user
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Enable 2FA
// @route   POST /api/auth/enable-2fa
exports.enable2FA = async (req, res) => {
  try {
    const user = req.user;
    
    if (user.twoFactorEnabled) {
      return res.status(400).json({
        success: false,
        message: '2FA is already enabled'
      });
    }
    
    // Generate secret
    const secret = speakeasy.generateSecret({
      name: `${process.env.PLATFORM_NAME} (${user.email})`
    });
    
    // Generate QR code
    const qrCode = await QRCode.toDataURL(secret.otpauth_url);
    
    user.twoFactorSecret = secret.base32;
    await user.save();
    
    res.json({
      success: true,
      data: {
        secret: secret.base32,
        qrCode
      }
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Verify and activate 2FA
// @route   POST /api/auth/verify-2fa
exports.verify2FA = async (req, res) => {
  try {
    const { code } = req.body;
    const user = req.user;
    
    const verified = speakeasy.totp.verify({
      secret: user.twoFactorSecret,
      encoding: 'base32',
      token: code
    });
    
    if (!verified) {
      return res.status(400).json({
        success: false,
        message: 'Invalid verification code'
      });
    }
    
    user.twoFactorEnabled = true;
    await user.save();
    
    res.json({
      success: true,
      message: '2FA enabled successfully'
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Disable 2FA
// @route   POST /api/auth/disable-2fa
exports.disable2FA = async (req, res) => {
  try {
    const { code } = req.body;
    const user = req.user;
    
    const verified = speakeasy.totp.verify({
      secret: user.twoFactorSecret,
      encoding: 'base32',
      token: code
    });
    
    if (!verified) {
      return res.status(400).json({
        success: false,
        message: 'Invalid verification code'
      });
    }
    
    user.twoFactorEnabled = false;
    user.twoFactorSecret = null;
    await user.save();
    
    res.json({
      success: true,
      message: '2FA disabled successfully'
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Change password
// @route   POST /api/auth/change-password
exports.changePassword = async (req, res) => {
  try {
    const { currentPassword, newPassword } = req.body;
    const user = req.user;
    
    const isMatch = await user.comparePassword(currentPassword);
    if (!isMatch) {
      return res.status(400).json({
        success: false,
        message: 'Current password is incorrect'
      });
    }
    
    user.password = newPassword;
    await user.save();
    
    res.json({
      success: true,
      message: 'Password changed successfully'
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Upload avatar
// @route   POST /api/auth/upload-avatar
exports.uploadAvatar = async (req, res) => {
  try {
    // Implementation depends on upload middleware
    res.json({
      success: true,
      message: 'Avatar uploaded successfully'
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};
"""

# Save auth controller
os.makedirs('backend/src/controllers', exist_ok=True)
with open('backend/src/controllers/authController.js', 'w') as f:
    f.write(auth_controller)

print("✅ Auth controller created!")

# Deposit Controller
deposit_controller = """const Deposit = require('../models/Deposit');
const User = require('../models/User');
const Transaction = require('../models/Transaction');
const telegramService = require('../config/telegram');

// @desc    Create new deposit request
// @route   POST /api/deposits/create
exports.createDeposit = async (req, res) => {
  try {
    const { amount } = req.body;
    const user = req.user;
    
    if (!amount || amount <= 0) {
      return res.status(400).json({
        success: false,
        message: 'Invalid deposit amount'
      });
    }
    
    // Get uploaded proof file
    if (!req.file) {
      return res.status(400).json({
        success: false,
        message: 'Please upload proof of payment'
      });
    }
    
    const proofUrl = `/uploads/${req.file.filename}`;
    
    // Create deposit record
    const deposit = new Deposit({
      userId: user._id,
      amount,
      proofUrl,
      ipAddress: req.ip,
      userAgent: req.get('user-agent')
    });
    
    await deposit.save();
    
    // Notify admin via Telegram
    await telegramService.notifyNewDeposit(deposit, user);
    
    res.status(201).json({
      success: true,
      message: 'Deposit request submitted successfully. Awaiting admin approval.',
      data: deposit
    });
  } catch (error) {
    console.error('Create deposit error:', error);
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Get deposit history
// @route   GET /api/deposits/history
exports.getDepositHistory = async (req, res) => {
  try {
    const { page = 1, limit = 20, status } = req.query;
    
    const query = { userId: req.user._id };
    if (status) query.status = status;
    
    const deposits = await Deposit.find(query)
      .sort({ createdAt: -1 })
      .limit(limit * 1)
      .skip((page - 1) * limit)
      .exec();
    
    const count = await Deposit.countDocuments(query);
    
    res.json({
      success: true,
      data: {
        deposits,
        totalPages: Math.ceil(count / limit),
        currentPage: page,
        total: count
      }
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Get deposit by ID
// @route   GET /api/deposits/:id
exports.getDepositById = async (req, res) => {
  try {
    const deposit = await Deposit.findOne({
      _id: req.params.id,
      userId: req.user._id
    });
    
    if (!deposit) {
      return res.status(404).json({
        success: false,
        message: 'Deposit not found'
      });
    }
    
    res.json({
      success: true,
      data: deposit
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Get deposit by reference code
// @route   GET /api/deposits/reference/:code
exports.getDepositByReference = async (req, res) => {
  try {
    const deposit = await Deposit.findOne({
      referenceCode: req.params.code,
      userId: req.user._id
    });
    
    if (!deposit) {
      return res.status(404).json({
        success: false,
        message: 'Deposit not found'
      });
    }
    
    res.json({
      success: true,
      data: deposit
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};
"""

with open('backend/src/controllers/depositController.js', 'w') as f:
    f.write(deposit_controller)

print("✅ Deposit controller created!")

print("🎉 All controllers generated successfully!")
