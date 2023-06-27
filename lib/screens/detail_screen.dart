import 'package:flutter/material.dart';

class Detail_screen extends StatefulWidget {
  final String nombre;
  final List<Map<String, dynamic>> objetos;

  Detail_screen({required this.nombre, required this.objetos});

  @override
  State<Detail_screen> createState() => _Detail_screenState();
}

class _Detail_screenState extends State<Detail_screen> {
  List<Map<String, dynamic>> get objetos => widget.objetos;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: objetos.length,
        itemBuilder: (context, index) {
          final objeto = objetos[index];

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
    );
  }
}

aumentarCantidad(int index) {}

reducirCantidad(int index) {}
