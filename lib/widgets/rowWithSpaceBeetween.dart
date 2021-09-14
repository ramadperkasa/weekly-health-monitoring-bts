import 'package:flutter/material.dart';

class RowWithSpaceBetween extends StatelessWidget {
  RowWithSpaceBetween({this.image, this.title, this.value, this.onPress});
  final Widget image;
  final String title;
  final Widget value;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  image,
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              value,
              // onPress != null
              //     ? Padding(
              //         padding: const EdgeInsets.only(left: 8.0),
              //         child: Icon(
              //           Icons.arrow_forward_ios_rounded,
              //           color: Colors.black54,
              //           size: 15,
              //         ),
              //       )
              //     : Container()
            ],
          ),
        ),
        Center(
          child: Divider(
            height: 20,
            thickness: 1,
            color: Color(0xFFF4F4F4),
            indent: 30,
          ),
        ),
        SizedBox(
          height: 12.0,
        )
      ],
    );
  }
}
