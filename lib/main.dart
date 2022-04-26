import 'dart:async';
import 'dart:ui';
import 'package:atcsearch/Home.dart';
import 'package:atcsearch/Login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.grey,
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


       if (s == true) {
    Timer(
          Duration(seconds: 3),
              () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Home())));
    }else{
      Timer(
          Duration(seconds: 3),
              () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Login())));

    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

            Image.asset("images/atclogo.jpg"),



        ])
    );



  }
}
