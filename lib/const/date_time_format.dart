import 'package:intl/intl.dart';

class FormatDate {
  FormatDate({this.dateTime});
  String dateTime;

  String formatDate() {
    return DateFormat.yMMMd().format(DateTime.parse(dateTime));
  }

  String formatTime() {
    return DateFormat.jm().format(DateTime.parse(dateTime));
  }
}
