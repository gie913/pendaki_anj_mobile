import 'package:intl/intl.dart';

class ValueManager {
  static String generateIDFromDateTime(DateTime now) {
    String iDTime = now.year.toString().substring(2) +
        DateFormat('MM').format(now) +
        DateFormat('dd').format(now) +
        DateFormat('HH').format(now) +
        DateFormat('mm').format(now) +
        DateFormat('ss').format(now);
    return iDTime;
  }

  static String dateFormatted(String dateTime) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    return inputFormat.format(DateTime.parse(dateTime));
  }
}