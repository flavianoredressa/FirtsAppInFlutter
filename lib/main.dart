import 'package:flutter/material.dart';
void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}



class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //Variaveis
  TextEditingController weightController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  String _info = 'Informe seu dados';

  //Funções
  _resetText(){
    weightController.text = '';
    heightController.text = '';
    setState(() {
    _info = 'Informe seu dados';
    });
  }
  _calcula(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);
      if(imc < 18.6){
        _info = 'Abaixo do peso (${imc.toStringAsPrecision(3)})';
      }
    });



  }
  //Fim Funções

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculando IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetText
          )
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(Icons.phone_locked, size: 120.0, color: Colors.green),
          TextField(
            keyboardType: TextInputType.number, 
            decoration: InputDecoration(labelText: 'Peso (kg)', labelStyle: TextStyle(color: Colors.indigo, fontSize: 15.0)),
            controller: weightController,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 25.0),
          ),
          TextField(
            keyboardType: TextInputType.number, 
            decoration: InputDecoration(labelText: 'Altura (cm)',labelStyle: TextStyle(color: Colors.green, fontSize: 15.0)),
            controller: heightController,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 25),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child:  Container(
            height: 50,
            child:RaisedButton(
              onPressed: _calcula,
              child: Text('Calcular', 
              style: TextStyle(color: Colors.white, fontSize: 25),),
              color: Colors.green
            ),
          ),
        ),
        Text(_info,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 25),
        )
        ],
      ),
      ),
    );
  }
}
