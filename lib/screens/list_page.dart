import 'package:flutter/material.dart';
import 'package:hive_todolist_yt/contact.dart';
import 'package:hive_todolist_yt/hive_data.dart';
import 'package:hive_todolist_yt/screens/detail_screen.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({Key? key}) : super(key: key);

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  List<ShoppingList> shoppList = [];
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController tiendaController = TextEditingController();
  final HiveData hiveData = const HiveData();

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    nombreController.dispose();
    tiendaController.dispose();
    super.dispose();
  }

  Future<void> getData() async {
    shoppList = await hiveData.buyList;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: nombreController,
            ),
            TextFormField(
              controller: tiendaController,
            ),
            ElevatedButton(
              onPressed: () async {
                await hiveData
                    .saveList(
                      ShoppingList(
                        nombre: nombreController.text,
                        tienda: tiendaController.text,
                        objetosAsociados: [], // Aquí puedes agregar los objetos asociados si los tienes
                      ),
                    )
                    .then((value) => print(value));
                await getData();
              },
              child: const Text('Add'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: shoppList.length,
                itemBuilder: (context, index) {
                  final shoppingList = shoppList[index];
                  return ListTile(
                    title: Text(shoppingList.nombre),
                    subtitle: Text(shoppingList.tienda),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detail_screen(
                            nombre: shoppingList.nombre,
                            objetos: shoppingList.objetosAsociados,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
