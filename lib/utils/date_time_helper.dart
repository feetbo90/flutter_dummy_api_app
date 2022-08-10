
import 'package:intl/intl.dart';

class DateTimeHelper {
  static String format(DateTime date) {
    // Date and Time Format
    var value = DateFormat.yMMMMEEEEd().format(date);
    return value;
  }

  static String myTime(DateTime date) {
    // Date and Time Format
    var value = DateFormat.yMEd().add_jms().format(date);
    return value;
  }
}