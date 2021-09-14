import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:m_whm/screen/login/forgot_password/forgot_password.dart';
import 'package:m_whm/screen/login/forgot_password/reset_password.dart';
import 'package:m_whm/screen/login/login.dart';
import 'package:m_whm/screen/main/dashboard.dart';
import 'package:m_whm/screen/main/form_success.dart';
import 'package:m_whm/screen/main/form_survey.dart';
import 'package:m_whm/screen/main/history_notification.dart';
import 'package:m_whm/screen/main/profile.dart';
import 'package:m_whm/screen/main/profile_change.dart';

var dashboardHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Dashboard();
});

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Login();
});

var passwordResetHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ResetPassword();
});

var passwordForgotHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ForgotPassword();
});

var profileHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Profile();
});

var profileChangeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ProfileChange();
});

var historyNotificationHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HistoryNotification();
});

var formSuccessHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return FormSuccess();
});

var formSurveyHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return FormSurvey();
});
