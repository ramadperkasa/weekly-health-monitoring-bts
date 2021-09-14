import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:m_whm/constants/color.dart';
import 'package:m_whm/db/db_questioner.dart';
import 'package:m_whm/services/network.dart';
import 'package:m_whm/widgets/history/item_list_history.dart';
import 'package:m_whm/widgets/no_data.dart';

class HistoryListView extends StatefulWidget {
  @override
  _HistoryListViewState createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  var dBQuestioner = DBQuestioner();

  List row = [];

  final dbRef = FirebaseDatabase.instance.reference().child("questions").once();

  bool loading = false;

  @override
  void initState() {
    getAll();

    super.initState();
  }

  void getAll() async {
    setState(() {
      loading = true;
    });

    List item = await dBQuestioner.queryAllRows();

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // var data = await NetworkHelper().getData(
        //   'https://weekly-health-monitoring-default-rtdb.firebaseio.com/questions.json',
        // );

        // var getInstance = FirebaseFirestore.instance.collection('quesioner');

        // await getInstance
        //     .orderBy('date', descending: true)
        //     .get()
        //     .then((QuerySnapshot querySnapshot) {
        //   querySnapshot.docs.forEach((doc) {
        //     row.add(doc.data());
        //   });
        // });

        // row = row.toList();

      }
    } on SocketException catch (_) {
      row = item
          .where(
            (element) =>
                element['user'] ==
                FirebaseAuth.instance.currentUser.email.toString(),
          )
          .toList()
          .reversed
          .toList();
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(BaseColors.primary),
        ),
      );
    } else {
      return FutureBuilder(
          future: dbRef,
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.hasData) {
              List lists = [];

              if (snapshot.data.value != null &&
                  snapshot.data.value.length > 0) {
                snapshot.data.value.forEach((key, values) {
                  lists.add(values);
                });

                return lists.length > 0
                    ? ListView.builder(
                        itemCount: lists.length,
                        itemBuilder: (context, index) {
                          return ItemListHistory(
                            row: lists[index],
                          );
                        })
                    : NoData(
                        text: 'No History Available',
                      );
              } else {
                return NoData(
                  text: 'No History Available',
                );
              }
            } else if (snapshot.hasError) {
              return NoData(
                text: 'No History Available',
              );
            }
            return Center(
                child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(BaseColors.primary),
            ));
          });
    }
  }
}
