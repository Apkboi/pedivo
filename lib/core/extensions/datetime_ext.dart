import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String get sessionDayLabel => DateFormat('EEE').format(this);

  String get sessionTimeLabel => DateFormat('h:mm a').format(this);

  String get sessionDateLabel => DateFormat('MMM d').format(this);

  String get sessionRelativeLabel {
    final now = DateTime.now();
    final date = DateTime(year, month, day);
    final today = DateTime(now.year, now.month, now.day);
    if (date == today) return 'Today';
    if (date == today.subtract(const Duration(days: 1))) return 'Yesterday';
    return DateFormat('MMM d').format(this);
  }
}
