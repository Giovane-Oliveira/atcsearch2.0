import 'dart:convert';

import 'package:atcsearch/Home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  static const String _title = 'ATC Search';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
          backgroundColor: Colors.black,
        ),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  _logado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', true);
    //bool? boolValue = prefs.getBool('boolValue');

  }

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _verifica_usuario() async {
    if (nameController.text.isEmpty || passwordController.text.isEmpty) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Aviso!'),
              content: const Text('Informe usuário e senha'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    } else {
      String url = "http://192.168.200.11/readpass.php?tipo=login&usuario=" +
          nameController.text +
          "&senha=" +
          passwordController.text;
      http.Response response;
      response = await http.get(Uri.parse(url));
      Map<String, dynamic> retorno = json.decode(response.body);


      if (retorno["nome"].toString().contains(
          nameController.text.toUpperCase()) &&
          retorno["senha"].toString().contains(
              passwordController.text.toUpperCase())) {
        _logado();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => Home(),
          ),

        );
      } else if (retorno["nome"].toString() == "null") {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                title: const Text('Aviso!'),
                content: const Text('Usuário ou senha incorretos'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'images/atclogo.jpg',
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Usuário',
                  prefixIcon: Icon(Icons.verified_user),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.key),
                ),
              ),
            ),
            /* Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 0.50),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  prefixIcon: Icon(Icons.key),
                  labelText: 'Senha',
                    labelStyle: TextStyle(
                        color:  Colors.black
                    ),
              ),
                      cursorColor: Colors.black,
            ),
            ),*/

            Container(
                height: 60,
                padding: const EdgeInsets.fromLTRB(120, 20, 120, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    // print(nameController.text);
                    //print(passwordController.text);
                    _verifica_usuario();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,

                    /*Color primary, // set the background color
                    Color onPrimary,
                    Color onSurface,
                    Color shadowColor,
                    double elevation,
                    TextStyle textStyle,
                    EdgeInsetsGeometry padding,
                    Size minimumSize,
                    BorderSide side,
                    OutlinedBorder shape,
                    MouseCursor enabledMouseCursor,
                    MouseCursor disabledMouseCursor,
                    VisualDensity visualDensity,
                    MaterialTapTargetSize tapTargetSize,
                    Duration animationDuration,
                    bool enableFeedback*/
                  ),
                )),
          ],
        ));
  }
}