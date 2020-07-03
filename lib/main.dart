import 'package:flutter/material.dart';

main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.5) {
        _infoText = "Você está desnutrido";
      } else if (imc >= 18.5 && imc <= 24.9) {
        _infoText = "Você está com o peso normal";
      } else if (imc >= 25.0 && imc <= 29.9) {
        _infoText = "Você está começando a ficar acima do peso";
      } else if (imc >= 30.0 && imc <= 34.9) {
        _infoText = "Vish está ruim a situação";
      } else {
        _infoText = "Eita, agora lascou!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[200],
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  size: 120.0,
                  color: Colors.deepPurple[200],
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (Kg)",
                      labelStyle: TextStyle(color: Colors.deepPurple[200])),
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.deepPurple[200], fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu peso";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.deepPurple[200])),
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.deepPurple[200], fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira sua altura";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                      height: 50,
                      child: RaisedButton(
                          child: Text(
                            "Calcular",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                          color: Colors.deepPurple[200],
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _calculate();
                            }
                          })),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepPurple[300], fontSize: 20),
                ),
              ],
            )),
      ),
    );
  }
}
