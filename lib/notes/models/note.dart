import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final bool isImportant;
  @HiveField(4)
  final bool isResolved;
  @HiveField(5)
  final DateTime createdAt;
  @HiveField(6)
  final DateTime? updatedAt;

  Note({
    required this.id,
    required this.title,
    this.description,
    required this.isImportant,
    required this.isResolved,
    required this.createdAt,
    this.updatedAt,
  });
}
