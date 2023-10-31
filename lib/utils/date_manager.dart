import 'package:intl/intl.dart';

class DateManager {

  static const String dateFormat = 'dd-MM-yyyy';

  static String formatDateToString(DateTime dateTime, {String dateFormat = dateFormat}) {

    try {

      return DateFormat(dateFormat).format(dateTime);
    } catch (ex) {

      return '';
    }
  }

  static DateTime? formatStringToDate(String date, {String dateFormat = dateFormat}) {

    try {

      return DateFormat(dateFormat).parse(date);
    } catch (ex) {

      return null;
    }
  }

  static String todayDate({String dateFormat = dateFormat}) {
    return DateFormat(dateFormat).format(DateTime.now());
  }
}