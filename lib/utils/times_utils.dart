class TimesUtils {
  static bool hoursPassed(DateTime? from, DateTime to, int hours) {
    if (from == null) {
      return true;
    }
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return to.difference(from).inHours > hours;
  }
}
