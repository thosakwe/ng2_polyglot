class Location {
  final int line, index;

  Location(this.line, this.index);

  @override
  bool operator ==(other) {
    return other is Location && other.index == index && other.line == line;
  }

  @override
  String toString() => '$line:$index';
}
