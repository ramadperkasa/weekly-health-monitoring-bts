import 'package:flutter/material.dart';
import 'package:m_whm/constant/color.dart';

class ButtonBlock extends StatelessWidget {
  ButtonBlock({
    this.text,
    @required this.onPress,
    this.isDisabled = false,
    this.color = BaseColors.primary,
  });
  final String text;
  final Function onPress;
  final bool isDisabled;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPress,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.w800, letterSpacing: 0.8),
      ),
      style: ElevatedButton.styleFrom(
          primary: BaseColors.primary,
          minimumSize: Size(MediaQuery.of(context).size.width, 50)),
    );
  }
}
