import 'package:flutter/material.dart';
import 'package:m_whm/components/card_profile.dart';
import 'package:m_whm/components/item_list.dart';
import 'package:m_whm/components/layout.dart';
import 'package:m_whm/components/tab_dashboard.dart';
import 'package:m_whm/const/color.dart';
import 'package:m_whm/components/drawer.dart';

enum ActiveTab { Active, History }

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ActiveTab activeTab = ActiveTab.Active;

  void setActiveTab(ActiveTab tabPass) {
    setState(() {
      activeTab = tabPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    double ratioHeight = 1.13;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: BaseColors.darkerPrimary),
        child: Drawer(child: DrawerList()),
      ),
      body: Layout(
        enabledPadding: false,
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
        isDrawer: true,
        ratioHeight: ratioHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardProfile(onPressed: () {
              Navigator.pushNamed(context, '/profile');
            }),
            Container(
              height: 8.0,
              width: double.infinity,
              color: Color(0xFFF3F3F3),
            ),
            SizedBox(height: 8.0),
            TabDashboard(
              activeTab: activeTab,
              onActivePressed: () => setActiveTab(ActiveTab.Active),
              onHistoryPressed: () => setActiveTab(ActiveTab.History),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return ItemList(
                      isActive: activeTab == ActiveTab.Active ? true : false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
