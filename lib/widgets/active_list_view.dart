import 'package:flutter/material.dart';
import 'package:m_whm/constants/color.dart';
import 'package:m_whm/state/question.dart';
import 'package:m_whm/widgets/item_list.dart';
import 'package:m_whm/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ActiveListView extends StatefulWidget {
  @override
  _ActiveListViewState createState() => _ActiveListViewState();
}

class _ActiveListViewState extends State<ActiveListView> {
  bool loading = false;
  List quesionerList = [];

  @override
  void initState() {
    fetchQuestion();

    super.initState();
  }

  void fetchQuestion() async {
    try {
      setState(() {
        loading = true;
      });

      await context.read<QuestionData>().fetchQuestion();

      quesionerList = Provider.of<QuestionData>(context, listen: false)
          .quesionerLists['data'];

      setState(() {
        loading = false;
      });
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(
          'Terjadi Kesalahan',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
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
      return quesionerList.length > 0
          ? ListView.builder(
              itemCount: quesionerList.length,
              itemBuilder: (context, index) {
                var item = quesionerList[index];

                return ItemList(
                  isActive: true,
                  title: item['title'],
                  expiredDate: item['expired_date'],
                  status: item['status'],
                  questions: item['questions'],
                );
              },
            )
          : NoData(
              text: 'No Active Form',
            );
    }
  }
}
