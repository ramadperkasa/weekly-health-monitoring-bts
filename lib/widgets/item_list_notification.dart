import 'package:flutter/material.dart';
import 'package:m_whm/constants/color.dart';

import 'package:m_whm/constants/date_time_format.dart';
import 'package:m_whm/screen/loading_screen.dart';

class ItemListNotification extends StatelessWidget {
  ItemListNotification({
    this.isActive = false,
    this.title,
    this.expiredDate,
    this.notificationTitle,
    this.notificationBody,
  });

  final String title;
  final String notificationTitle;
  final String notificationBody;
  final DateTime expiredDate;

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isActive
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoadingScreen();
                },
              ),
            )
          : '',
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Icon(
                  Icons.notifications,
                  size: 50.0,
                  color: BaseColors.primary,
                )),
            Expanded(
              flex: 10,
              child: Container(
                margin: EdgeInsets.only(top: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notificationTitle ?? '',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      notificationBody,
                      style: TextStyle(fontSize: 13.0),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      title,
                      style: TextStyle(fontSize: 17.0),
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
                                  FormatDate(dateTime: expiredDate.toString())
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
                                  FormatDate(dateTime: expiredDate.toString())
                                      .formatTime(),
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
                                  color: isActive
                                      ? BaseColors.success
                                      : BaseColors.error,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3.0, horizontal: 12.0),
                                  child: Text(
                                    isActive ? 'Active' : 'Expired',
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
    );
  }
}
