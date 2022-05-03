import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ControleVendas/ControleVendas.dart';
import 'Login.dart';
import 'Quality2/Quality2.dart';

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
//https://www.fluttericon.com/

class Home extends StatelessWidget {
  static const String _title = 'Sistemas ATC';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar:   AppBar(
          backgroundColor: Color(0xFF040404),
      automaticallyImplyLeading: false,
      title: Text(
        '$_title',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontSize: 22,
        ),
      ),
      actions: [

        Align(
          alignment: Alignment.center,
          child: Text(
            "Sair",
            textScaleFactor: 1.5,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),

        IconButton(icon: Icon(Icons.logout), onPressed: () {

          showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
            title: const Text('Aviso!'),
            content: const Text('Deseja mesmo sair?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(

                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool('boolValue', false);
                  //Fecha a ultima tela ao fazer logout
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);

          },
                child: const Text('Continue'),
              ),
            ],
          ),
          );

        }),

      ],
      centerTitle: false,
      elevation: 2,
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




  @override
  Widget build(BuildContext context) {
      SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown, //Forçar orientação da tela
    ]);
    return SafeArea(
      child: GestureDetector(
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(4),
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          crossAxisCount: 3,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 20,
              color: Colors.white,
              child: Center(
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Quality2(),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.assessment_rounded,
                        size: 80.0,
                        color: Colors.black,
                      ),
                      Text(
                          "Quality2",
                        style: TextStyle(

                          color: Colors.black,

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 20,
              color: Colors.white,
              child: Center(
                    child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ControleVendas(),
                      ),
                    ),
                child: Column(

                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Icon( Icons.paste, size:80.0),
                    Text("Controle Vendas"),

                  ],
                ),
                ),
              ),

            ),


            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 20,
              color: Colors.white,
              child: Center(
                /*child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Quality2(),
                      ),
                    ),*/
                child: Column(

                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Icon( FontAwesome.envira, size:80.0,),
                    Text("Fumo Cru"),

                  ],
                ),
                ),
              ),

           // ),



          ],
        ),
      ),

    );

  }
}


