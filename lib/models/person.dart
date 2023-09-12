import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 1)
class Person {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String surname;

  @HiveField(2)
  final String how;

  @HiveField(3)
  final String when;

  @HiveField(4)
  final String revenge;

  Person({
    required this.name,
    required this.surname,
    required this.how,
    required this.when,
    required this.revenge,
  });
}
