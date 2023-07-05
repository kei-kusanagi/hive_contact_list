import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todolist_yt/contact.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class HiveData {
  const HiveData();

  Future<int> saveContact(Contact contact) async {
    final Box<Contact> box = await Hive.openBox<Contact>('contactsBox');
    return box.add(contact);
  }

  Future<List<Contact>> get contacts async {
    final Box<Contact> box = await Hive.openBox<Contact>('contactsBox');
    return box.values.toList();
  }

  Future<int> saveList(ShoppingList shoppingList) async {
    final Box<ShoppingList> box =
        await Hive.openBox<ShoppingList>('buyListBox');
    return box.add(shoppingList);
  }

  Future<List<ShoppingList>> get buyList async {
    final Box<ShoppingList> box =
        await Hive.openBox<ShoppingList>('buyListBox');
    return box.values.toList();
  }

  Future<void> addObjectToShoppingList(
      int shoppingListIndex, Map<String, dynamic> objeto) async {
    final Box<ShoppingList> box =
        await Hive.openBox<ShoppingList>('buyListBox');
    final ShoppingList? shoppingList = box.get(shoppingListIndex);
    shoppingList?.agregarObjeto(objeto);
    await shoppingList!.save();
  }
}
