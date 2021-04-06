import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:m_whm/components/card_profile.dart';
import 'package:m_whm/components/layout.dart';
import 'package:m_whm/constant/color.dart';

class Profile extends StatelessWidget {
  final double ratioHeight = 1.13;
  final TextStyle kTextValueStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Layout(
        enabledPadding: false,
        isDrawer: false,
        ratioHeight: ratioHeight,
        title: Text('Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 18.0, 8.0),
            child: Badge(
              position: BadgePosition(top: 7, end: 3),
              badgeColor: BaseColors.accent,
              child: Image.asset(
                'assets/icons/ic_notification.png',
                height: 25,
                width: 25,
              ),
            ),
          )
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardProfile(),
            Container(
              height: 8.0,
              width: double.infinity,
              color: Color(0xFFF3F3F3),
            ),
            SizedBox(height: 8.0),
            Container(
              margin: EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Personal Information'),
                  SizedBox(
                    height: 18.0,
                  ),
                  RowWithSpaceBetween(
                    image: Image.asset(
                      'assets/icons/ic_identity.png',
                      height: 25,
                      width: 25,
                    ),
                    title: 'NIK',
                    value: Text(
                      'ITA.EMP.00018',
                      style: kTextValueStyle,
                    ),
                  ),
                  RowWithSpaceBetween(
                    image: Image.asset('assets/icons/ic_email.png',
                        height: 25, width: 25),
                    title: 'Email',
                    value: Text(
                      'rama.d@bts.id',
                      style: kTextValueStyle,
                    ),
                  ),
                  RowWithSpaceBetween(
                    image: Image.asset('assets/icons/ic_telephone.png',
                        height: 25, width: 25),
                    title: 'Phone Number',
                    value: Text(
                      '088971753162',
                      style: kTextValueStyle,
                    ),
                  ),
                  RowWithSpaceBetween(
                    image: Image.asset('assets/icons/ic_gender.png',
                        height: 25, width: 25),
                    title: 'Gender',
                    value: Text(
                      'Male',
                      style: kTextValueStyle,
                    ),
                  ),
                  RowWithSpaceBetween(
                    image: Image.asset('assets/icons/ic_padlock.png',
                        height: 25, width: 25),
                    title: 'Password',
                    value: Text(
                      'Change Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: BaseColors.accent,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RowWithSpaceBetween extends StatelessWidget {
  RowWithSpaceBetween({this.image, this.title, this.value});
  final Image image;
  final String title;
  final Text value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
          ],
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
