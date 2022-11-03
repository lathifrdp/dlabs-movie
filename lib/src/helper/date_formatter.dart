import 'package:intl/intl.dart';

String formatDateNullable(String? dateStr) {
  String? date;
  if (dateStr != null) {
    date = formatDateNotNullable(dateStr);
  }
  if (dateStr == null) {
    date = "-";
  }
  return date!;
}

String formatDateNotNullable(String dateStr) {
  var date = DateTime.parse(dateStr);
  const String cultureInfo = "id_ID";

  String tanggal = DateFormat("d MMMM yyyy", cultureInfo).format(date);

  var timeFormat = DateFormat(DateFormat.HOUR24_MINUTE);

  if (!isTimeEquals(date, 0, 0, 0)) {
    tanggal += " (${timeFormat.format(date)})";
  }

  return tanggal;
}

bool isTimeEquals(DateTime date, int hour, int minute, int second) {
  return date.hour == hour && date.minute == minute && date.second == second;
}
