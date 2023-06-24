import 'package:flutter/material.dart';
import 'package:hive_todolist_yt/contact.dart';
import 'package:hive_todolist_yt/hive_data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final HiveData hiveData = const HiveData();
  List<Contact> contacts = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    numberController.dispose();
    super.dispose();
  }

  Future<void> getData() async {
    contacts = await hiveData.contacts;
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
              controller: controller,
            ),
            TextFormField(
              controller: numberController,
            ),
            ElevatedButton(
                onPressed: () async {
                  await hiveData
                      .saveContact(
                        Contact(
                            name: controller.text,
                            number: numberController.text),
                      )
                      .then((value) => print(value));
                  await getData();
                },
                child: const Text('Add')),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(contacts![index].name),
                    subtitle: Text(contacts![index].number),
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
