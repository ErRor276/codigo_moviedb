extension ListExtensions on List {
  String toCommasString() {
    String result = "";
    for (var element in this) {
      result += "$element,";
    }
    return result.substring(0, result.length - 1);
  }
}
