import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:m_whm/const/color.dart';
import 'package:m_whm/screen/login/forgot_password/forgot_password.dart';
import 'package:m_whm/screen/login/forgot_password/reset_password.dart';
import 'package:m_whm/screen/main/dashboard.dart';

import 'package:m_whm/screen/main/form_success.dart';
import 'package:m_whm/screen/main/form_survey.dart';
import 'package:m_whm/screen/login/login.dart';
import 'package:m_whm/screen/main/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode savedThemeMode;

  const MyApp({Key key, this.savedThemeMode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) {
        return MaterialApp(
          theme: ThemeData(
            primaryColor: BaseColors.primary,
            fontFamily: 'Nunito',
          ),
          title: 'Backdrop Demo',
          // home: MainContent(),
          initialRoute: '/login',
          routes: {
            '/': (context) => Dashboard(),
            '/login': (context) => Login(),
            '/forgot-password': (context) => ForgotPassword(),
            '/reset-password': (context) => ResetPassword(),
            '/profile': (context) => Profile(),
            '/form-success': (context) => FormSuccess(),
            '/form-survey': (context) => FormSurvey()
          },
        );
      },
    );
  }
}
