DateTime parseDate(dynamic obj) {
  if (obj is String) {
    return DateTime.parse(obj);
  }
  if (obj is DateTime) {
    return obj;
  }
  if (obj is int) {
    return DateTime.fromMillisecondsSinceEpoch(obj);
  }
  throw Exception('Invalid date object $obj');
}

DateTime? safeParseDate(dynamic obj) {
  if (obj is String) {
    return DateTime.tryParse(obj);
  }
  if (obj is DateTime) {
    return obj;
  }
  if (obj is int) {
    return DateTime.fromMillisecondsSinceEpoch(obj);
  }
  return null;
}
