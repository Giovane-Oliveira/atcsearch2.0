import 'dart:ui';
import 'package:atcsearch/Login.dart';
import 'package:atcsearch/Quality2/ConsultaCostumer.dart';
import 'package:atcsearch/ControleVendas/ControleQualidade/CQDegradation.dart';
import 'package:atcsearch/ControleVendas/ControleQualidade/CQMoinsture.dart';
import 'package:atcsearch/ControleVendas/ControleQualidade/CQNicotineAndSugar.dart';
import 'package:atcsearch/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

import '../ControleVendas.dart';
//https://www.fluttericon.com/

class ControleQualidade extends StatelessWidget {
  //static const String _title = 'Quality2';

  _logado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', false);
    //bool? boolValue = prefs.getBool('boolValue');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Controle de Qualidade",
        theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        appBarTheme: AppBarTheme(
        //backgroundColor: Colors.black,
        //foregroundColor: Colors.white, //here you can give the text color
    )
    //accentColor: Colors.orange,
    ),
    home: Scaffold(
    appBar: AppBar(
    leading: BackButton(
    color: Colors.white,
    onPressed: () {
    Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context) => ControleVendas()));
    }),
    title: Text(
    "Controle de Qualidade",
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
    IconButton(
    icon: Icon(Icons.logout),
    onPressed: () {
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
    onPressed: () {
    _logado();
    /*    Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Login(),
                          ),

                        );*/
    //Fecha a ultima tela ao fazer logout
    Navigator.of(context).pushNamedAndRemoveUntil(
    '/login', (Route<dynamic> route) => false);
    },
    child: const Text('Continue'),
    ),
    ],
    ),
    );
    }),
    ],
    //backgroundColor: Colors.black,
    ),
    body: MyStatefulWidget()
    ,
    ));
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
                  onTap: () =>
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CQNicotineAndSugar())),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesome.beaker,
                        size: 80.0,
                        color: Colors.blueGrey,
                      ),
                      Text("Nic & Sugar", style: TextStyle(color: Colors.blueGrey),),
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
                  onTap: () =>
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => CQMoinsture())),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Typicons.temperatire, color: Colors.blueGrey, size: 80.0),
                      Text("Moisture", style: TextStyle(color: Colors.blueGrey),),
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
                  onTap: () =>
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => CQDegradation())),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.waterfall_chart,
                        color: Colors.blueGrey,
                        size: 80.0,
                      ),
                      Text("Degradation", style: TextStyle(color: Colors.blueGrey),),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    /*GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/atclogo.jpg',
                    width: 200,
                    height: 100,
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => NicotineAndSugar(),
                              ),
                            ), // needed
                            child: Image.asset(
                              "images/laboratorio.jpg",
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'images/produtoacabado.jpg',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'images/fumocru.jpg',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '      Quality2',
                        ),
                        Text(
                          'Produto Acabado',
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 17, 0),
                          child: Text(
                            'Fumo Cru',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );*/
  }
}
