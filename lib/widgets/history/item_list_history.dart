import 'package:flutter/material.dart';
import 'package:m_whm/constants/color.dart';

import 'package:m_whm/constants/date_time_format.dart';
import 'package:m_whm/screen/main/history_detail.dart';

class ItemListHistory extends StatelessWidget {
  ItemListHistory({this.row});

  final dynamic row;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HistoryDetail(
              row: row,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFFF4F4F4),
              spreadRadius: 5,
              blurRadius: 15,
              offset: Offset.zero,
            ),
          ],
        ),
        margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        padding: EdgeInsets.fromLTRB(6.0, 18.0, 6.0, 18.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoryDetail(
                  row: row,
                ),
              ),
            );
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset('assets/icons/ic_form_active.png',
                      height: 50, width: 50),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    margin: EdgeInsets.only(top: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          row['name'],
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Expired Date : '),
                                  Container(
                                    margin: EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      FormatDate(dateTime: row['date'])
                                          .formatDate(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Expired Time : '),
                                  Container(
                                    margin: EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      FormatDate(
                                        dateTime: row['date'].toString(),
                                      ).formatTime(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Status'),
                                  Container(
                                    margin: EdgeInsets.only(top: 6.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: BaseColors.error,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3.0, horizontal: 12.0),
                                      child: Text(
                                        'Expired',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
