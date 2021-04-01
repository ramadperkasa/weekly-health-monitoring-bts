import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_whm/const/color.dart';
import 'package:m_whm/screen/main/dashboard.dart';

class TabDashboard extends StatelessWidget {
  TabDashboard({this.activeTab, this.onActivePressed, this.onHistoryPressed});
  final ActiveTab activeTab;
  final Function onActivePressed;
  final Function onHistoryPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: onActivePressed,
                child: Text(
                  'Active',
                  style: TextStyle(
                    color: activeTab == ActiveTab.Active
                        ? Colors.black
                        : BaseColors.placeholder,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: TextButton(
                  onPressed: onHistoryPressed,
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  child: Text(
                    'History',
                    style: TextStyle(
                      color: activeTab == ActiveTab.History
                          ? Colors.black
                          : BaseColors.placeholder,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: activeTab == ActiveTab.Active
                    ? EdgeInsets.only(bottom: 3)
                    : null,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: activeTab == ActiveTab.Active
                          ? BaseColors.primary
                          : Color(0xFFF4F4F4),
                      width: activeTab == ActiveTab.Active ? 4 : 1,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: activeTab == ActiveTab.History
                    ? EdgeInsets.only(bottom: 3)
                    : null,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: activeTab == ActiveTab.History
                          ? BaseColors.primary
                          : Color(0xFFF4F4F4),
                      width: activeTab == ActiveTab.History ? 4 : 1,
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
