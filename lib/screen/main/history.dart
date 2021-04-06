import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:m_whm/components/card_profile.dart';
import 'package:m_whm/components/layout.dart';
import 'package:m_whm/constant/color.dart';
import 'package:m_whm/screen/main/history_detail.dart';
import 'package:m_whm/sqlite/db_helper.dart';
import 'dart:collection';

class HistoryMonitoring extends StatefulWidget {
  @override
  _HistoryMonitoringState createState() => _HistoryMonitoringState();
}

class _HistoryMonitoringState extends State<HistoryMonitoring> {
  final double ratioHeight = 1.13;
  var dbHelper = DBHelper();
  bool loading = false;
  List row = [];

  @override
  void initState() {
    getAll();

    super.initState();
  }

  void getAll() async {
    setState(() {
      loading = true;
    });

    row = await dbHelper.queryAllRows();

    print(row);

    setState(() {
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
            title: Text('History'),
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
                  child: ListView.builder(
                    itemCount: groupBy(row, (obj) => obj['date']).length,
                    itemBuilder: (context, val) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoryDetail(
                                row: row.where(
                                  (element) =>
                                      element['date'] ==
                                      groupBy(
                                        row,
                                        (obj) => obj['date'],
                                      ).keys.toList()[val].toString(),
                                ),
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Image.asset(
                              'assets/icons/ic_form_active.png',
                              height: 50,
                              width: 50),
                          title: Text(row[val]['name']),
                          subtitle: Text(
                            DateFormat.yMMMMEEEEd().add_jm().format(
                                  DateTime.parse(
                                    groupBy(
                                      row,
                                      (obj) => obj['date'],
                                    ).keys.toList()[val].toString(),
                                  ),
                                ),
                          ),
                        ),
                      );
                    },
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
