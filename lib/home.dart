import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _recuperaCep() async {
    String cep = "99740000";
    var uri = Uri.http("viacep.com.br", "/ws/${cep}/json");

    http.Response res;
    res = await http.get(uri);
    if (res.statusCode == 200) {
      Map<String, dynamic> data = convert.jsonDecode(res.body);

      String logradouro = data["logradouro"];
      String complemento = data["complemento"];
      String bairro = data["bairro"];
      String cidade = data["cidade"];
    } else {
      print("Erro ${res.statusCode}");
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
    return Container();
  }
}
