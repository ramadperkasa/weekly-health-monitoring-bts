import 'package:flutter/material.dart';
import 'package:m_whm/constants/color.dart';
import 'package:m_whm/widgets/active_list_view.dart';
import 'package:m_whm/widgets/card_profile.dart';
import 'package:m_whm/widgets/history/history_list_view.dart';
import 'package:m_whm/widgets/layout.dart';
import 'package:m_whm/widgets/drawer.dart';
import 'package:m_whm/services/push_notification.dart';

enum ActiveTab { Active, History }

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ActiveTab activeTab = ActiveTab.Active;

  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    PushNotificationService().handleInAppNotification(context);

    super.initState();
  }

  void setActiveTab(ActiveTab tabPass) {
    setState(() {
      activeTab = tabPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    double ratioHeight = 1.13;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: BaseColors.darkerPrimary,
        ),
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
            DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Expanded(
                child: Column(children: <Widget>[
                  TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: BaseColors.placeholder,
                    indicatorColor: BaseColors.primary,
                    indicatorWeight: 4.0,
                    labelStyle: TextStyle(fontSize: 18.0),
                    tabs: [
                      Tab(text: 'Active'),
                      Tab(text: 'History'),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: TabBarView(children: <Widget>[
                        ActiveListView(),
                        HistoryListView()
                      ]),
                    ),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
