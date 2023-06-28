import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todolist_yt/contact.dart';
import 'package:hive_todolist_yt/hive_data.dart';

var currencyFormatter =
    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}?$'));

class Detail_screen extends StatefulWidget {
  final String nombre;
  final List<Map<String, dynamic>> objetos;

  Detail_screen({required this.nombre, required this.objetos});

  @override
  State<Detail_screen> createState() => _Detail_screenState();
}

class _Detail_screenState extends State<Detail_screen> {
  FocusNode productoFocusNode = FocusNode();
  final TextEditingController productoController = TextEditingController();
  final TextEditingController valorUnitarioController = TextEditingController();
  final TextEditingController unidadesController = TextEditingController();
  final HiveData hiveData = const HiveData();

  List<Map<String, dynamic>> get objetos => widget.objetos;
  List<ShoppingList> productos = [];
  late ShoppingList shoppingList;

  @override
  void initState() {
    super.initState();
    Hive.openBox<ShoppingList>('shoppingLists');
    shoppingList = ShoppingList(
      nombre: widget.nombre,
      tienda: '',
      objetosAsociados: widget.objetos,
    );

    getData();
    super.initState();
  }

  @override
  void dispose() {
    productoController.dispose();
    valorUnitarioController.dispose();
    unidadesController.dispose();
    super.dispose();
  }

  Future<void> getData() async {
    productos = await hiveData.buyList;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nombre),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: productoController,
              focusNode: productoFocusNode,
              decoration: const InputDecoration(labelText: 'Producto'),
            ),
            TextField(
              controller: valorUnitarioController,
              decoration: const InputDecoration(
                  labelText: 'Valor unitario',
                  prefixText: '\$ ',
                  hintText: '00.00'),
              inputFormatters: [currencyFormatter],
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      int unidades = int.tryParse(unidadesController.text) ?? 0;
                      unidades = unidades > 0 ? unidades - 1 : 0;
                      unidadesController.text = unidades.toString();
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: unidadesController,
                    decoration: const InputDecoration(
                        labelText: 'Unidades', hintText: '1'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      int unidades = int.tryParse(unidadesController.text) ?? 0;
                      unidades = unidades + 1;
                      unidadesController.text = unidades.toString();
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final nombreProd = productoController.text;
                final valorUnit = valorUnitarioController.text;
                final unidades = unidadesController.text;

                agregarObjeto(nombreProd, valorUnit, unidades);
                getData();
              },
              child: const Text('Agregar producto'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: objetos.length,
                itemBuilder: (context, index) {
                  final objeto = widget.objetos[index];

                  return Dismissible(
                    key: Key(objeto['producto']),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Eliminar elemento'),
                          content: const Text('¿Desea eliminar este elemento?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text('Aceptar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text('Cancelar'),
                            ),
                          ],
                        ),
                      );
                    },
                    onDismissed: (direction) {
                      setState(() {
                        objetos.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Producto eliminado')),
                      );
                    },
                    child: ListTile(
                      leading: Checkbox(
                        value: objeto['check'],
                        onChanged: (value) {
                          setState(() {
                            objeto['check'] = value;
                          });
                        },
                      ),
                      title: Text(objeto['producto']),
                      subtitle: Text('\$ ${objeto['valor']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => reducirCantidad(index),
                          ),
                          Text(objeto['unidades'].toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => aumentarCantidad(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  agregarObjeto(
    String nombreProd,
    String valorUnit,
    String unidades,
  ) {
    final nuevoObjeto = {
      'producto': nombreProd,
      'valor': valorUnit,
      'unidades': unidades,
      'check': false,
    };

    shoppingList.objetosAsociados.add(nuevoObjeto);
    Hive.box<ShoppingList>('shoppingLists')
        .put(2, shoppingList); // Utiliza la instancia de shoppingList

    productoController.clear();
    valorUnitarioController.clear();
    unidadesController.clear();
  }

  aumentarCantidad(int index) {}

  reducirCantidad(int index) {}
}
