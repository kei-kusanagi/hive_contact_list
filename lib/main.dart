import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todolist_yt/contact.dart';
import 'package:hive_todolist_yt/screens/home_page.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
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
