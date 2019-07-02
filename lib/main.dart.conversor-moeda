import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// const String url = 'https://newsapi.org/v2/top-headlines?country=br&category=technology&apiKey=59f57a2b05034632aa4038428afe2b26';
const String url = 'https://api.hgbrasil.com/finance';

void main() async {
  
  // print(await getNews());
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white
    ),
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
  TextEditingController realController = new TextEditingController();
  TextEditingController dolarController = new TextEditingController();
  TextEditingController euroController = new TextEditingController();
  dynamic dolar;
  dynamic euro;

void _realChanger(String text){
  double real = double.parse(text);
  dolarController.text = (real/dolar).toStringAsFixed(2);
  euroController.text = (real/euro).toStringAsFixed(2);
}
void _dolarChanger(String text){
 double dolar = double.parse(text);
 realController.text = (dolar * this.dolar).toStringAsFixed(2);
 euroController.text = (dolar * this.dolar/euro).toStringAsFixed(2);
}
void _euroChanger(String text){
 double euro = double.parse(text);
 realController.text = (euro * this.euro).toStringAsFixed(2);
 dolarController.text = (euro * this.euro/dolar).toStringAsFixed(2);
}
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
                  dolar = snapshot.data['results']['currencies']['USD']['buy'];
                  euro = snapshot.data['results']['currencies']['EUR']['buy'];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.monetization_on, size: 150,  color: Colors.amber,),
                        criarInputs('Reais', 'R\$', realController, _realChanger),
                        Divider(),
                        criarInputs('Dólares', 'US\$', dolarController, _dolarChanger),
                        Divider(), 
                        criarInputs('Euros', '€', euroController, _euroChanger)
                      ],
                    ),
                  );
                }
           }
        })
       );
  }
}

 Widget criarInputs(String label, String prefixo, TextEditingController ctrl, Function funcao){
      return TextField(
        controller: ctrl,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
          prefixText: prefixo,
        ),
        style: TextStyle(color: Colors.amber, fontSize: 25),
        onChanged: funcao,
      );
 }
