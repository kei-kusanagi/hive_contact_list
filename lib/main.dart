import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todolist_yt/contact.dart';
import 'package:hive_todolist_yt/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(ContactAdapter());
  Hive.registerAdapter(ShoppingListAdapter());
  await Hive.initFlutter();
  Hive.openBox<Contact>('contact');
  Hive.openBox<ShoppingList>('shoppingLists');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var myPrimaryColor = Colors.deepPurple;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: myPrimaryColor,
        ),
        useMaterial3: true,
      ).copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: myPrimaryColor,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}
