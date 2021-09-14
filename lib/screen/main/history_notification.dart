import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:m_whm/constants/color.dart';
import 'package:m_whm/widgets/card_profile.dart';
import 'package:m_whm/widgets/item_list_notification.dart';
import 'package:m_whm/widgets/layout.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HistoryNotification extends StatefulWidget {
  @override
  _HistoryNotificationState createState() => _HistoryNotificationState();
}

class _HistoryNotificationState extends State<HistoryNotification> {
  final double ratioHeight = 1.13;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List notification = [];
  bool loading = false;

  @override
  void initState() {
    getPreferences();

    super.initState();
  }

  getPreferences() async {
    loading = true;
    final SharedPreferences prefs = await _prefs;
    setState(() {
      List value = jsonDecode(
        prefs.getString('notification') ?? jsonEncode([]),
      );
      notification = value.reversed.toList();
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Layout(
            enabledPadding: false,
            isDrawer: false,
            ratioHeight: ratioHeight,
            title: Text('Notification History'),
            child: Column(
              children: [
                CardProfile(),
                Container(
                  height: 8.0,
                  width: double.infinity,
                  color: Color(0xFFF3F3F3),
                ),
                SizedBox(height: 8.0),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: notification.length ?? 0,
                          itemBuilder: (context, index) {
                            Map item = notification[index];
                            return ItemListNotification(
                              title: item['title'],
                              notificationBody: item['notificationBody'],
                              notificationTitle: item['notificationTitle'],
                              expiredDate: DateTime.parse(item['expiredDate']),
                              isActive: item['status'] == '1' ? true : false,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          loading
              ? Container(
                  color: Colors.white.withOpacity(0.6),
                  child: SpinKitFoldingCube(
                    color: BaseColors.primary.withOpacity(0.3),
                    size: 75.0,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
