import 'package:flutter/material.dart';
import 'package:testes/models/item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teste',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppHome(),
    );
  }
}

class AppHome extends StatefulWidget {
  var item = new List<Item>();

  AppHome() {
    item = [];

    item.add(Item(done: false, title: "Tarefa 1"));
    item.add(Item(done: true, title: "Tarefa 2"));
    item.add(Item(done: false, title: "Tarefa 3"));
  }

  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  var newTaslCtrl = TextEditingController();

  void add() {
    if (newTaslCtrl.text.isEmpty) return;
    setState(() {
      widget.item.add(
        Item(done: false, title: newTaslCtrl.text),
      );
      newTaslCtrl.text = "";
    });
  }

  void remove(int index) {
    setState(() {
      widget.item.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaslCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          decoration: InputDecoration(
              labelText: "Nova Tarefa",
              labelStyle: TextStyle(
                color: Colors.white,
              )),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.item.length,
        itemBuilder: (BuildContext context, int index) {
          final item = widget.item[index];
          return Dismissible(
            child: CheckboxListTile(
              title: Text(item.title),
              value: item.done,
              onChanged: (value) {
                setState(() {
                  item.done = value;
                });
              },
            ),
            key: Key(item.title),
            background: Container(
              color: Colors.red.withOpacity(0.2),
            ),
            onDismissed: (direction) {
              //print(direction);
              remove(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
