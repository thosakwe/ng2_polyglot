class Location {
  final String filename;
  final int line, index;

  Location(this.filename, this.line, this.index);

  @override
  bool operator ==(other) {
    return other is Location && other.index == index && other.line == line;
  }

  @override
  String toString() => '$filename:$line:$index';
}
