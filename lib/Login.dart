import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:fluttericon/brandico_icons.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/fontelico_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/maki_icons.dart';
import 'package:fluttericon/meteocons_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:fluttericon/zocial_icons.dart';

import 'package:atcsearch/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  static const String _title = 'Sistemas ATC';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          appBarTheme: AppBarTheme(
            // backgroundColor: Colors.black,
            foregroundColor: Colors.white, //here you can give the text color
          )
        //accentColor: Colors.orange,

      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title, style: TextStyle( fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 22,fontWeight: FontWeight.bold),),
          // backgroundColor: Colors.black,
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
  late bool _isObscure = true;

  @override
  void initState() {
    super.initState();

    setState(() {
      _verificar_internet();
    });
  }

  _verificar_internet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Aviso!'),
          content:
          const Text('O dispositivo não está conectado com a internet'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

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
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Aviso!'),
          content: const Text('Informe usuário e senha'),
          actions: <Widget>[
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
      if (retorno["nome"]
          .toString()
          .contains(nameController.text.toUpperCase()) &&
          retorno["senha"]
              .toString()
              .contains(passwordController.text.toUpperCase())) {
        _logado();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else if (retorno["nome"].toString() == "null") {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Aviso!'),
            content: const Text('Usuário ou senha incorretos'),
            actions: <Widget>[
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown, //Forçar orientação da tela
      // DeviceOrientation.landscapeLeft,
      // DeviceOrientation.landscapeRight,
    ]);
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
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
                  prefixIcon: Icon(FontAwesome.user),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: _isObscure,
                controller: passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.key),
                    suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        })),
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
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login', style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    // print(nameController.text);
                    //print(passwordController.text);
                    _verifica_usuario();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,

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