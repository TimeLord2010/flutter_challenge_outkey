class Location {
  double latitude, longitude;
  Location({
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() {
    return '(${longitude.toStringAsFixed(4)}, ${latitude.toStringAsFixed(4)})';
  }
}
