class Note {
  final String title;
  final String? description;
  final bool isImportant;
  final bool isResolved;

  Note(
      {required this.title,
      this.description,
      required this.isImportant,
      required this.isResolved});
}
