import 'package:flutter/material.dart';

// Control the language of every page (reactive variable)
// Object being monitored for changes
final ValueNotifier<String> globalLanguage = ValueNotifier<String>('zh'); // Initialize

const Map<String, Map<String, String>> textLanguage = {
  'en': {
    'appTitle': 'Healthcare Visit Helper APP',
    'userLogin': 'User Login',
    'email': 'Email',
    'password': 'Password',
    'confirmPassword': 'Confirm Password',
    'forgotPassword': 'Forgot your password? Reset here',
    'login': 'Login',
    'dontHaveAccount': "Don't have an account? Register here",
    'registerAccount': 'Register Account',
    'register': 'Register',
    'resetPassword': 'Reset Password',
    'enterEmail': 'Enter your email',
    'sendResetLink': 'Send Reset Link',
    'pleaseEnterEmailPassword': 'Please enter both email and password',
    'loginSuccess': 'Login successful!',
    'loginFail': 'Login failed!',
    'pleaseFillAll': 'Please fill in all fields',
    'passwordNotMatch': 'Passwords do not match',
    'registerSuccess': 'Registration successful!',
    'registerFail': 'Registration failed:',
    'resetSent': 'Password reset email sent',
    'resetError': 'Error:',

    // Home Page texts
    'clinicRecommender': 'Clinic Recommendation System',
    'selectCity': 'Select your city:',
    'commonSymptoms': 'Common symptoms (multi-select):',
    'inputSymptoms': 'Please describe your symptoms',
    'submitFirst': 'Get Recommendation',
    'submitFollowUp': 'Answer Follow-up',
    'searchFailed': 'Search failed, please try again later.',
    'errorOccurred': 'An error occurred:',
  },
  'zh': {
    'appTitle': '看診建議APP',
    'userLogin': '使用者登入',
    'email': '電子信箱',
    'password': '密碼',
    'confirmPassword': '確認密碼',
    'forgotPassword': '忘記密碼？在這裡重設',
    'login': '登入',
    'dontHaveAccount': '沒有帳號？點此註冊',
    'registerAccount': '註冊帳號',
    'register': '註冊',
    'resetPassword': '重設密碼',
    'enterEmail': '請輸入電子信箱',
    'sendResetLink': '發送重設連結',
    'pleaseEnterEmailPassword': '請輸入電子信箱與密碼',
    'loginSuccess': '登入成功！',
    'loginFail': '登入失敗！',
    'pleaseFillAll': '請填寫所有欄位',
    'passwordNotMatch': '兩次密碼輸入不一致',
    'registerSuccess': '註冊成功！',
    'registerFail': '註冊失敗：',
    'resetSent': '已寄送密碼重設信',
    'resetError': '錯誤：',

    // Home Page words
    'clinicRecommender': '診所推薦系統',
    'selectCity': '選擇所在縣市：',
    'commonSymptoms': '點選常見症狀（可複選）：',
    'inputSymptoms': '請輸入您的症狀',
    'submitFirst': '推薦診所',
    'submitFollowUp': '回覆問題',
    'searchFailed': '搜尋失敗，請稍後再試。',
    'errorOccurred': '發生錯誤：',
  }
};