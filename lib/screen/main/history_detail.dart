import 'package:flutter/material.dart';
import 'package:m_whm/components/layout.dart';
import 'package:m_whm/constant/color.dart';

class HistoryDetail extends StatelessWidget {
  HistoryDetail({row}) {
    this.row = row.toList();
  }
  List row;
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
                  itemCount: row.length,
                  itemBuilder: (context, key) {
                    return ListTile(
                      title: Text((key + 1).toString() +
                          '. ' +
                          row[key]['question'].toString()),
                      subtitle: Row(
                        children: [
                          row[key]['answer'].toString() == 'YA'
                              ? Icon(
                                  Icons.check,
                                  color: BaseColors.success,
                                )
                              : Icon(
                                  Icons.close,
                                  color: BaseColors.error,
                                ),
                          Text(
                            row[key]['answer'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: row[key]['answer'].toString() == 'YA'
                                  ? BaseColors.success
                                  : BaseColors.error,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
