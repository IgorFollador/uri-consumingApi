import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerCep = TextEditingController();
  String _resultado = "...";
  _recuperaCep() async {
    String cep = _controllerCep.text;
    var uri = Uri.http("viacep.com.br", "/ws/${cep}/json");

    http.Response res;
    res = await http.get(uri);
    if (res.statusCode == 200) {
      Map<String, dynamic> data = convert.jsonDecode(res.body);

      String logradouro = data["logradouro"];
      String complemento = data["complemento"];
      String bairro = data["bairro"];
      String localidade = data["localidade"];

      setState(() {
        _resultado = "$localidade $logradouro $bairro $complemento";
      });
    } else {
      print("Erro ${res.statusCode.toString}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recuperaCep();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: "Digite seu cep favorito: "),
              style: TextStyle(fontSize: 22),
              controller: _controllerCep,
            ),
            ElevatedButton(
                onPressed: _recuperaCep, child: Text("Buscar Cidade")),
            Text(_resultado)
          ],
        ),
      ),
    );
  }
}
