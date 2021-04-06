import 'package:flutter/material.dart';
import 'package:m_whm/components/textfield.dart';
import 'package:m_whm/constant/color.dart';

class DetailInformationCard extends StatelessWidget {
  DetailInformationCard({this.onPress});
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 16.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFF4F4F4),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          KTextField(
            keyboardType: TextInputType.streetAddress,
            label: 'Destination',
            placeholder: 'Enter Your Destination',
          ),
          Container(
            margin: EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: KTextField(
                    keyboardType: TextInputType.datetime,
                    prefixIcon: Image.asset('assets/icons/ic_calendar.png',
                        height: 25, width: 25),
                    label: 'From',
                    placeholder: 'DD/MM/YYYY',
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: KTextField(
                    keyboardType: TextInputType.datetime,
                    prefixIcon: Image.asset('assets/icons/ic_calendar.png'),
                    label: 'To',
                    placeholder: 'DD/MM/YYYY',
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12.0),
            child: KTextField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              label: 'Reason',
              placeholder: 'Enter Your Reason',
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Divider(
            color: Color(0xFFF4F4F4),
          ),
          SizedBox(height: 10.0),
          GestureDetector(
            onTap: onPress,
            child: Center(
                child: Text(
              'Delete',
              style: TextStyle(
                color: BaseColors.primary,
              ),
            )),
          )
        ],
      ),
    );
  }
}
