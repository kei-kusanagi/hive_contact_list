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
}
