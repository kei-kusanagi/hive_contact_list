import 'package:flutter/material.dart';
import 'package:hive_todolist_yt/contact.dart';
import 'package:hive_todolist_yt/hive_data.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({Key? key}) : super(key: key);

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  List<String> nombres = [];
  List<String> tiendas = [];
  List<Map<String, dynamic>> listaProductos = [];

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController tiendaController = TextEditingController();
  final HiveData hiveData = const HiveData();
  List<ShoppingList> shoppList = [];

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
                            objetosAsociados: listaProductos),
                      )
                      .then((value) => print(value));
                  await getData();
                },
                child: const Text('Add')),
            Expanded(
              child: ListView.builder(
                itemCount: shoppList.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(shoppList![index].nombre),
                    subtitle: Text(shoppList![index].tienda),
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
