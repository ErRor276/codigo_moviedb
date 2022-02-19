extension StringExtensions on String {
  List toIntList() {
    List<String> splits = split(",");
    return [...List.generate(splits.length, (i) => int.parse(splits[i]))];
  }
}
