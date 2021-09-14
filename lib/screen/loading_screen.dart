import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:m_whm/constants/color.dart';
import 'package:m_whm/screen/main/dashboard.dart';

import 'package:m_whm/screen/main/form_survey.dart';
import 'package:m_whm/state/question.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    fetchQuestion();

    super.initState();
  }

  void fetchQuestion() async {
    try {
      await context.read<QuestionData>().fetchQuestion();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return FormSurvey();
          },
        ),
      );
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(
          'Terjadi Kesalahan',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Dashboard();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.darkerPrimary,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/img_background_sidebar.png',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/img_background_sidebar.png',
                fit: BoxFit.cover,
              ),
            ],
          ),
          SpinKitFoldingCube(
            color: Colors.white24,
            size: 75.0,
          ),
        ],
      ),
    );
  }
}
