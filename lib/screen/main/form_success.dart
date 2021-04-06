import 'package:flutter/material.dart';
import 'package:m_whm/components/button_block.dart';
import 'package:m_whm/constant/color.dart';

class FormSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset('assets/images/img_successfuly.png',
                        fit: BoxFit.contain),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Successfully',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'You have successfully submitted a Weekly Health Monitoring survey',
                    style: TextStyle(color: BaseColors.subtitle),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              ButtonBlock(
                onPress: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (Route<dynamic> route) => false,
                  );
                },
                text: 'Back',
              )
            ],
          ),
        ),
      ),
    );
  }
}
