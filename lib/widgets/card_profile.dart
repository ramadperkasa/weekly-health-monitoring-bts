import 'package:flutter/material.dart';
import 'package:m_whm/constants/color.dart';
import 'package:m_whm/widgets/image/circle_image.dart';
import 'package:m_whm/widgets/futureBuilder.dart';

class CardProfile extends StatelessWidget {
  CardProfile({this.onPressed});
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            KCircleImage(),
            ListTile(
              title: Center(
                child: FutureBuilder(
                  future: getDataAsync(context, 'name'),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                        ),
                      );
                    } else {
                      return Text('Loading...');
                    }
                  },
                ),
              ),
              subtitle: Center(
                child: FutureBuilder(
                  future: getDataAsync(context, 'position'),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data,
                        style: TextStyle(
                          color: BaseColors.primary,
                          fontSize: 15.0,
                        ),
                      );
                    } else {
                      return Text('Loading...');
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
