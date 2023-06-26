import 'package:hive_flutter/hive_flutter.dart';

part 'contact.g.dart';

@HiveType(typeId: 0)
class Contact extends HiveObject {
  Contact({required this.name, required this.number});

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String number;
}

@HiveType(typeId: 1)
class ShoppingList extends HiveObject {
  @HiveField(0)
  late String nombre;

  @HiveField(1)
  late String tienda;

  @HiveField(2)
  late List<Map<String, dynamic>> objetosAsociados;
}
