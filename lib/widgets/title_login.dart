import 'package:flutter/material.dart';
import 'package:m_whm/constants/color.dart';
import 'package:m_whm/widgets/wrap_text.dart';

class TitleLogin extends StatelessWidget {
  TitleLogin({this.title, this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700,
                    color: BaseColors.title),
              ),
              SizedBox(
                height: 5.0,
              ),
              WrapText(
                text: Text(
                  subtitle,
                  style: TextStyle(
                      color: BaseColors.subtitle,
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
