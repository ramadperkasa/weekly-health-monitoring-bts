import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m_whm/constant/color.dart';

class DrawerList extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/img_background_sidebar.png',
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/img_background_sidebar.png',
              fit: BoxFit.cover,
            ),
          ],
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 12.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextButton.icon(
                          label: Text(''),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Image.asset(
                            'assets/icons/ic_close.png',
                            height: 25,
                            width: 25,
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/profile'),
                    child: ListTile(
                      leading: Hero(
                        tag: 'account',
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.asset(
                            'assets/images/avatar.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      title: Text(
                        'Rama Dwiyantara Perkasa',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.0),
                      ),
                      subtitle: Text(
                        'Junior Programmer',
                        style: TextStyle(
                            color: BaseColors.secondary, fontSize: 15.0),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 9.0),
                child: Column(
                  children: [
                    Divider(
                      thickness: 2.0,
                      color: Colors.white,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _auth.signOut();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (Route<dynamic> route) => false);
                      },
                      child: ListTile(
                        leading: Image.asset('assets/icons/ic_log_out.png',
                            height: 25, width: 25),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
