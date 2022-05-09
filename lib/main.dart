import 'dart:async';
import 'dart:ui';
import 'package:atcsearch/Home.dart';
import 'package:atcsearch/Login.dart';
import 'package:atcsearch/Quality2/ConsultaCostumer.dart';
import 'package:atcsearch/Quality2/Degradation.dart';
import 'package:atcsearch/Quality2/NicotineAndSugar.dart';
import 'package:atcsearch/Quality2/Quality2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Introdution.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      "/login": (context) => Login(),
      "/intro": (context) => Introdution(),
      "/home": (context) => Home(),
      '/quality': (context) => Quality2(),
      "/consultacostumer": (context) => ConsultaCostumer(),
      '/degradation': (context) => Degradation(),
      "/nicotine": (context) => NicotineAndSugar(),
    },
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistemas ATC',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double value = 0;

  @override
  void initState() {
    super.initState();

    _verificalogado();
  }

  //continuação
  _verificalogado() async {
    //_logado();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? s = prefs.getBool('boolValue');
    bool? i = prefs.getBool('intro');
    //print("dsadasdasdd" + s.toString());
    if (i == null && s == null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Introdution())));
    } else if (s == true && i == true) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home())));
    } else if (s == false && i == true) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login())));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/world.png"),
                      fit: BoxFit.contain)),
            ),
          ),
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}

/*
Segunda tela, pode ser implementado diversas telas num único arquivo .dart

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("GeeksForGeeks")),
      body: Center(
          child:Text("Home page",textScaleFactor: 2,)
      ),
    );
  }
}*/
