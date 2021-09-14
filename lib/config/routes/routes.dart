import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {
  static String dashboard = "/";
  static String login = "/login";
  static String passwordReset = "/password/reset";
  static String passwordForgot = "/password/forgot";
  static String profile = "/profile";
  static String profileChange = "/profile/change";
  static String historyNotification = "/history/notification";
  static String formSuccess = "/form/success";
  static String formSurvey = "/form/survey";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return;
    });

    router.define(dashboard, handler: dashboardHandler);
    router.define(login, handler: loginHandler);
    router.define(passwordReset, handler: passwordResetHandler);
    router.define(passwordForgot, handler: passwordForgotHandler);
    router.define(profile, handler: profileHandler);
    router.define(profileChange, handler: profileChangeHandler);
    router.define(historyNotification, handler: historyNotificationHandler);
    router.define(formSuccess, handler: formSuccessHandler);
    router.define(formSurvey, handler: formSurveyHandler);
  }
}
