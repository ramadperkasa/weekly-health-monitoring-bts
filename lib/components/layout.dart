import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:m_whm/constant/color.dart';

class Layout extends StatelessWidget {
  Layout({
    this.child,
    this.imageUrl,
    this.ratioHeight = 1.60,
    this.onPressed,
    this.isDrawer = false,
    this.enabledPadding = true,
    this.title = const Text(''),
    this.isAppBar = true,
    this.actions,
  });
  final Widget child;
  final String imageUrl;
  final double ratioHeight;
  final Function onPressed;
  final bool isDrawer;
  final bool enabledPadding;
  final Widget title;
  final bool isAppBar;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double height = fullHeight / ratioHeight;

    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: BaseColors.darkerPrimary,
          child: Stack(
            children: [
              Container(
                height: fullHeight - fullHeight / 1.70,
                child: Image.asset(
                  'assets/images/img_background_sidebar.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 25.0),
                height: fullHeight - height,
                child: imageUrl != null
                    ? Center(
                        child: Container(
                          height: (fullHeight - height) / ratioHeight,
                          child: Image.asset(imageUrl, fit: BoxFit.contain),
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
        isDrawer
            ? Container(
                height: fullHeight - height,
                child: AppBar(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  leading: TextButton.icon(
                      onPressed: onPressed,
                      icon: Image.asset('assets/icons/ic_hamburger_menu.png',
                          height: 25, width: 25),
                      label: Text('')),
                  toolbarHeight: fullHeight - height,
                  title: Text(
                    'Dashboard',
                    style: TextStyle(fontSize: 25.0),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/history'),
                        child: Badge(
                          position: BadgePosition(top: 7, end: 3),
                          badgeColor: BaseColors.accent,
                          child: Image.asset(
                            'assets/icons/ic_notification.png',
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : isAppBar
                ? Container(
                    height: fullHeight - height,
                    child: AppBar(
                      centerTitle: true,
                      leading: IconButton(
                        icon: Image.asset(
                          'assets/icons/ic_arrow_left.png',
                          height: 25,
                          width: 25,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      actions: actions,
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      title: title,
                    ),
                  )
                : Container(),
        Column(
          verticalDirection: VerticalDirection.up,
          children: [
            Container(
              padding: enabledPadding
                  ? EdgeInsets.symmetric(vertical: 40.0, horizontal: 25.0)
                  : EdgeInsets.all(0.0),
              width: double.infinity,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: child,
            ),
          ],
        )
      ],
    );
  }
}
