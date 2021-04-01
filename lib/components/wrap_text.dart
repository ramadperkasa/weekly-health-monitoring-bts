import 'package:flutter/material.dart';

class WrapText extends StatelessWidget {
  WrapText({this.text});
  final Text text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [text],
      ),
    );
  }
}
