import 'package:flutter/material.dart';
import 'package:m_whm/constants/color.dart';
import 'package:m_whm/state/account.dart';
import 'package:m_whm/widgets/card_profile.dart';
import 'package:m_whm/widgets/futureBuilder.dart';
import 'package:m_whm/widgets/layout.dart';
import 'package:m_whm/widgets/rowWithSpaceBeetween.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  final double ratioHeight = 1.13;
  final TextStyle kTextValueStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    AccountData providerAccount = Provider.of<AccountData>(context);
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, '/');
        return;
      },
      child: Scaffold(
        body: Layout(
          enabledPadding: false,
          isDrawer: false,
          ratioHeight: ratioHeight,
          title: Text('Profile'),
          actions: [
            HistoryIcon(),
          ],
          isHome: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardProfile(),
              Container(
                height: 8.0,
                width: double.infinity,
                color: Color(0xFFF3F3F3),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                              getData(context, 'nik'),
                              style: kTextValueStyle,
                            ),
                          ),
                          RowWithSpaceBetween(
                            image: Image.asset('assets/icons/ic_email.png',
                                height: 25, width: 25),
                            title: 'Email',
                            value: Text(
                              providerAccount.getCurrentEmail(),
                              style: kTextValueStyle,
                            ),
                          ),
                          RowWithSpaceBetween(
                            image: Image.asset('assets/icons/ic_telephone.png',
                                height: 25, width: 25),
                            title: 'Phone Number',
                            value: Text(
                              getData(context, 'phone_number'),
                              style: kTextValueStyle,
                            ),
                          ),
                          RowWithSpaceBetween(
                            image: Image.asset('assets/icons/ic_gender.png',
                                height: 25, width: 25),
                            title: 'Gender',
                            value: Text(
                              getData(context, 'gender') == 'L'
                                  ? 'Male'
                                  : 'Female',
                              style: kTextValueStyle,
                            ),
                          ),
                          RowWithSpaceBetween(
                            image: Icon(
                              Icons.account_circle,
                              color: BaseColors.primary,
                            ),
                            title: 'Profile',
                            value: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/profile/change');
                              },
                              child: Text(
                                'Change Profile',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  color: BaseColors.accent,
                                ),
                              ),
                            ),
                          ),
                          RowWithSpaceBetween(
                            image: Image.asset('assets/icons/ic_padlock.png',
                                height: 25, width: 25),
                            title: 'Password',
                            value: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/password/reset');
                              },
                              child: Text(
                                'Change Password',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  color: BaseColors.accent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Detail Jawaban'),
        content: Container(width: double.minPositive, child: null),
      );
    },
  );
}
