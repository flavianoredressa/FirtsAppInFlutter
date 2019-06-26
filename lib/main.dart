import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const String url = 'https://newsapi.org/v2/top-headlines?country=br&category=technology&apiKey=59f57a2b05034632aa4038428afe2b26';
// const String url = 'https://api.hgbrasil.com/finance';

void main() async {
  
  print(await getNews());
  runApp(MaterialApp(
    home: Home(),
  ));
}

Future<Map> getNews() async {
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic dolar;
  double euro;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
       appBar: AppBar(
         title: Text('Comsumindo API'),
         centerTitle: true,
         backgroundColor: Colors.amber[300],
         actions: <Widget>[
           IconButton(icon: Icon(Icons.refresh), onPressed: (){})
         ],
       ),
       body: FutureBuilder<Map>(
       future: getNews(),
         builder: (context, snapshot){
           switch(snapshot.connectionState){
             case ConnectionState.none:
             case ConnectionState.waiting:
                return Center(
                  child: Text('Carregando Dados',
                  style: TextStyle(color: Colors.amber, fontSize: 25),)
                );
                default:
                if(snapshot.hasError){
                  return Center(
                  child: Text('Erro ao carregar dados',
                  style: TextStyle(color: Colors.amber, fontSize: 25),)
                  );
                }else{
                  dolar = snapshot.data['articles'];
                  // dolar = snapshot.data['results']['currencies']['USD']['buy'];
                  // euro = snapshot.data['results']['currencies']['EUR']['buy'];
                  print(dolar);
                  // print(euro);
                  return Container( color: Colors.green);
                }
           }
        })
       );
  }
}

