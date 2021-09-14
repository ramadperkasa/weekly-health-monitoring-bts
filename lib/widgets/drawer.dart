import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:m_whm/config/routes/application.dart';
import 'package:m_whm/constants/color.dart';
import 'package:m_whm/widgets/image/circle_image.dart';
import 'package:m_whm/widgets/futureBuilder.dart';

class DrawerList extends StatefulWidget {
  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  final _auth = FirebaseAuth.instance;

  // String name;
  // String image;
  // String position;

  // @override
  // void initState() {
  //   providerAccount = Provider.of<AccountData>(context);

  //   super.initState();
  // }

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
                    onTap: () => Application.router.navigateTo(
                      context,
                      '/profile',
                      transition: TransitionType.inFromBottom,
                    ),
                    child: ListTile(
                      leading: KCircleImage(
                        width: 55,
                        height: 55,
                      ),
                      title: Text(
                        getData(context, 'name'),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.0),
                      ),
                      subtitle: Text(
                        getData(context, 'position'),
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
