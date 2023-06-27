import 'package:flutter/material.dart';
import 'package:hive_todolist_yt/screens/todo_page.dart';
import 'package:hive_todolist_yt/screens/list_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<String> _pageTitles = [
    'Todo List',
    'Buy List',
  ];

  final List<Widget> _pages = [
    TodoListPage(),
    MyListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(_pageTitles[_selectedIndex]), // Cambiar el título de la AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}
