import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:m_whm/constant/color.dart';
import 'package:m_whm/screen/main/form_survey.dart';
import 'package:m_whm/services/network.dart';

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
    var data = await NetworkHelper()
        .getData('https://private-6435f7-quesioner.apiary-mock.com/questions');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return FormSurvey(
            questionList: data,
          );
        },
      ),
    );
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
