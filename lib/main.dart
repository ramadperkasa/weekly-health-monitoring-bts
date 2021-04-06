import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m_whm/constant/color.dart';
import 'package:m_whm/screen/login/forgot_password/forgot_password.dart';
import 'package:m_whm/screen/login/forgot_password/reset_password.dart';
import 'package:m_whm/screen/main/dashboard.dart';

import 'package:m_whm/screen/main/form_success.dart';
import 'package:m_whm/screen/main/form_survey.dart';
import 'package:m_whm/screen/login/login.dart';
import 'package:m_whm/screen/main/history.dart';
import 'package:m_whm/screen/main/profile.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: BaseColors.primary,
        fontFamily: 'Nunito',
      ),
      title: 'Backdrop Demo',
      initialRoute: FirebaseAuth.instance.currentUser != null ? '/' : '/login',
      routes: {
        '/': (context) => Dashboard(),
        '/login': (context) => Login(),
        '/forgot-password': (context) => ForgotPassword(),
        '/reset-password': (context) => ResetPassword(),
        '/profile': (context) => Profile(),
        '/history': (context) => HistoryMonitoring(),
        '/form-success': (context) => FormSuccess(),
        '/form-survey': (context) => FormSurvey()
      },
    );
  }
}
