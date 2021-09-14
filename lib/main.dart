import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:m_whm/config/routes/application.dart';
import 'package:m_whm/config/routes/routes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:m_whm/constants/color.dart';
import 'package:m_whm/services/save_notification.dart';
import 'package:m_whm/state/question.dart';
import 'package:m_whm/state/account.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  SaveNotification().incrementCounter(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => QuestionData(),
        ),
        ChangeNotifierProvider(
          create: (_) => AccountData(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      toastTheme: ToastThemeData(
        background: BaseColors.primary,
        textColor: Colors.white,
      ),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: BaseColors.primary,
          fontFamily: 'Nunito',
        ),
        title: 'Weekly Health Monitoring',
        onGenerateRoute: Application.router.generator,
        initialRoute:
            FirebaseAuth.instance.currentUser != null ? '/' : '/login',
      ),
    );
  }
}
