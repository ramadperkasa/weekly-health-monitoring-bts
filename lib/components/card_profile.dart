import 'package:flutter/material.dart';
import 'package:m_whm/constant/color.dart';

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
            Hero(
              tag: 'account',
              child: ClipRRect(
                child: Image.asset(
                  'assets/images/avatar.png',
                  fit: BoxFit.contain,
                  scale: 1.70,
                ),
              ),
            ),
            ListTile(
              title: Center(
                child: Text(
                  'Rama Dwiyantara Perkasa',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                ),
              ),
              subtitle: Center(
                child: Text(
                  'Junior Programmer',
                  style: TextStyle(
                    color: BaseColors.primary,
                    fontSize: 15.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
