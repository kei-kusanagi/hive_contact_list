import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todolist_yt/contact.dart';

class HiveData {
  const HiveData();

  Future<int> saveContact(Contact contact) async {
    final Box<Contact> box = await Hive.openBox<Contact>('contacts');
    return box.add(contact);
  }

  Future<List<Contact>> get contacts async {
    final Box<Contact> box = await Hive.openBox<Contact>('contacts');
    return box.values.toList();
  }

  Future<int> saveList(Contact shoppingList) async {
    final Box<ShoppingList> box = await Hive.openBox<ShoppingList>('buyList');
    return box.add(shoppingList as ShoppingList);
  }

  Future<List<ShoppingList>> get buyList async {
    final Box<ShoppingList> box = await Hive.openBox<ShoppingList>('buyList');
    return box.values.toList();
  }
}
