import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:m_whm/constants/color.dart';
import 'package:m_whm/widgets/layout.dart';

class HistoryDetail extends StatelessWidget {
  HistoryDetail({this.row});

  final dynamic row;
  final double ratioHeight = 1.13;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Layout(
        enabledPadding: false,
        isDrawer: false,
        ratioHeight: ratioHeight,
        title: Text('Detail History'),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: row['question'].length,
                itemBuilder: (context, index) {
                  var question = row['question'][index];
                  var show = row['show'][index];
                  var answer = row['answer'][index];
                  var additional = jsonDecode(row['additional'])[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        show.toString().toLowerCase() ==
                                answer.toString().toLowerCase()
                            ? showAlertDialog(context, additional)
                            : Container();
                      },
                      child: ListTile(
                        title: Text((index + 1).toString() +
                            '. ' +
                            question.toString()),
                        subtitle: Row(
                          children: [
                            Chip(
                              label: Row(
                                children: [
                                  answer.toString() == 'YA'
                                      ? Icon(
                                          Icons.check,
                                          color: BaseColors.success,
                                        )
                                      : Icon(
                                          Icons.close,
                                          color: BaseColors.error,
                                        ),
                                  Text(
                                    answer.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: answer.toString() == 'YA'
                                          ? BaseColors.success
                                          : BaseColors.error,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            show.toString().toLowerCase() ==
                                    answer.toString().toLowerCase()
                                ? Chip(
                                    label: Icon(Icons.list_alt),
                                  )
                                : Container()
                          ],
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
    );
  }

  showAlertDialog(BuildContext context, additional) {
    List additionals = additional;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail Jawaban'),
          content: Container(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: additionals.length,
              itemBuilder: (context, int index) {
                var item = additionals[index];
                return Container(
                  child: Column(
                    children: [
                      ListTile(
                        isThreeLine: true,
                        title: Text(item['destination'] ?? ' - '),
                        subtitle: Text('Destination'),
                      ),
                      ListTile(
                        isThreeLine: true,
                        title: Text(item['from'] ?? ' - '),
                        subtitle: Text('from'),
                      ),
                      ListTile(
                        isThreeLine: true,
                        title: Text(item['to'] ?? ' - '),
                        subtitle: Text('to'),
                      ),
                      ListTile(
                        isThreeLine: true,
                        title: Text(item['reason'] ?? ' - '),
                        subtitle: Text('reason'),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
