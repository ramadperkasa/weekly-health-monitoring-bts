import 'package:flutter/material.dart';
import 'package:m_whm/constants/color.dart';

class NoData extends StatelessWidget {
  NoData({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/img_no_data_form.png',
            scale: 1.5,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            '$text',
            style: TextStyle(
              color: BaseColors.placeholder,
              fontWeight: FontWeight.w800,
              fontSize: 15.0,
            ),
          )
        ],
      ),
    );
  }
}
