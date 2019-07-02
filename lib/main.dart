import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

void main() {
 runApp(MaterialApp(
    home: Home(),
 ));
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = [];
  TextEditingController nova = TextEditingController();
  void _addList(){
    print(nova.text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarfas'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        ),
        body: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(children: <Widget>[
              Expanded(
                child:TextField(
                  controller: nova,
                decoration: InputDecoration(
                  labelText: 'Nova Tarefa',
                  labelStyle: TextStyle(color: Colors.blueAccent)
                )
                ),
              ),
              RaisedButton(
                color: Colors.blueAccent,
                child: Text('Add'),
                textColor: Colors.white,
                onPressed: _addList,
              ),
                                       
            ],
            ),
          ),
          Expanded(child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: _toDoList.length,
              itemBuilder: (context, index){
                return CheckboxListTile(
                  title: Text(_toDoList[index]['title']),
                  value: _toDoList[index]['ok'],
                  secondary: CircleAvatar(
                    child: Icon(_toDoList[index]['ok']?Icons.check: Icons.error),
                  ),
                );
              }))
        ],),
    );
  }
  Future<File> _getFile() async{
    final diretorio = await  getApplicationDocumentsDirectory();
    return File('${diretorio.path}/tarefas.json');
  }
  Future<File> _salveData() async{
    String data = json.encode(_toDoList);
    final file = await _getFile();
    file.writeAsString(data);
  }
  Future<String> _readData() async{
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}

