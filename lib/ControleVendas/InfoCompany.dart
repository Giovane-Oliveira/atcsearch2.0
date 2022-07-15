import 'dart:ui';
import 'package:atcsearch/ControleVendas/ControleQualidade/CQDegradation.dart';
import 'package:atcsearch/ControleVendas/ControleQualidade/CQMoinsture.dart';
import 'package:atcsearch/ControleVendas/ControleQualidade/CQNicotineAndSugar.dart';
import 'package:atcsearch/ControleVendas/Uncommited/Uncommited.dart';
import 'package:atcsearch/ControleVendas/Uncommited/ModelUncommited.dart';
import 'package:atcsearch/Quality2/Degradation.dart';
import 'package:atcsearch/Quality2/Moinsture.dart';
import 'package:intl/intl.dart';
import 'package:atcsearch/Quality2/ModelsQuality/ModelNS.dart';
import 'package:atcsearch/Quality2/NicotineAndSugar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

import '../Login.dart';

class InfoCompany extends StatefulWidget {
  String? interface;

  InfoCompany({this.interface});

  @override
  _InfoCompanyState createState() => _InfoCompanyState();
}

class _InfoCompanyState extends State<InfoCompany> {
  late Future<List<ModelUncommited>> _myData = _recuperarPostagens();
  late TextEditingController company;

  @override
  void initState() {
    super.initState();
    company = TextEditingController();


    setState(() {
      _opcao();
    });

    company.addListener(() {
      _recuperarPostagens();
    });


    final DateTime now = DateTime.now();
    final DateFormat formatter =
    DateFormat('yyyy'); //DateFormat('yyyy-MM-dd hh:mm');
    final String formatted = formatter.format(now);
    company.text = "";
  }

  _opcaoTrue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('bannerOpcaoCompany', false);
  }

  _opcao() async {
    bool rs;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? s = prefs.getBool('bannerOpcaoCompany');
    //print('EEEEEEE $s');
    if (s == true) {
      rs = true;
    } else if (s == false) {
      rs = false;
    } else {
      prefs.setBool('bannerOpcaoCompany', true);
      rs = true;
    }

    return rs;

    //bool? boolValue = prefs.getBool('boolValue');
  }

  Future<List<ModelUncommited>> _recuperarPostagens() async {
    String url = "http://192.168.200.11/read.php?tipo=uncommited";
    bool x = true;
    try {
      int.parse(company.text);
    } catch (Exception) {
      x = false;
      // print("sadsdasdasdsad");
    }
    if(company.text.isEmpty){


    } else if (x == false) {         //letras
      //   print("aaaqui 1");
      url = "http://192.168.200.11/read.php?tipo=uncommitedletras&descricao=" + company.text.toUpperCase() + "%";
    } else if (x == true) { // numeros
      //  print("aaaqui 2");
      url = "http://192.168.200.11/read.php?tipo=uncommitednumeros&codigo=" +
          company.text + "%";
    } else{


      url = "http://192.168.200.11/read.php?tipo=uncommited";


    }


    //SELECT COD_PESSOA, DES_PESSOA FROM VIEW_CLIENTES P WHERE P.des_pessoa like  'T%'




    http.Response response;
    response = await http.get(Uri.parse(url));
    var dadosJson = json.decode(response.body);
    List<ModelUncommited> postagens = <ModelUncommited>[];
    for (var post in dadosJson) {
      // print("post: " + post["cod_carga"] );
       ModelUncommited p = ModelUncommited(post["COD_PESSOA"], post["DES_PESSOA"]);
      postagens.add(p);
    }
    //print( postagens.toString() );

    return postagens;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Company",
        theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            appBarTheme: AppBarTheme(
              //backgroundColor: Colors.black,
              foregroundColor: Colors.white, //here you can give the text color
            )
          //accentColor: Colors.orange,
        ),
        home: Scaffold(
          appBar: AppBar(
           leading: BackButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Uncomitted()));
                }),
            title: Text(
              "Company",
            ),
            //backgroundColor: Colors.black,
          ),
          body: Column(mainAxisSize: MainAxisSize.max, children: [
            FutureBuilder<dynamic>(
                future: _opcao(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    //print("" + snapshot.data.toString());
                    return Visibility(
                        visible: snapshot.data ? true : false,
                        child: MaterialBanner(
                          content: const Text(
                              'Selecione a empresa que você deseja informações'),
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.business,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.blueGrey,
                          ),
                          actions: [
                            FlatButton(
                              child: const Text(
                                'Ocultar',
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                              onPressed: () {
                                setState(() {
                                  _opcaoTrue();
                                });
                              },
                            ),
                          ],
                        ));
                  } else {
                    return Container();
                  }
                }),

        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: TextFormField(
                      onChanged: (teste) {
                        setState(() {
                          _myData = _recuperarPostagens();
                        });
                      },
                      controller: company,
                      obscureText: false,
                      //   keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        // prefix: Text("Company: "),
                        isDense: true,
                        hintText: 'Inform the Company',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      //cursorColor: Colors.orange,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

            /* Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _myData = _recuperarPostagens();
                });
                // Respond to button press
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // Background color
              ),
              icon: Icon(Icons.search, size: 18),
              label: Text("Buscar"),
            )
          ],
        ),*/


            /**/
          ]),
        ),
      Expanded(
     child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
    child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: FutureBuilder<List<ModelUncommited>>(
                  future: _myData,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                        break;
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          print("lista: Erro ao carregar $snapshot");
                        } else {
                          print("lista: carregou!! ");
                          return ListView.separated(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              List<ModelUncommited> lista = snapshot.data ?? <ModelUncommited>[];
                              ModelUncommited post = lista[index];

                              return ListTile(
                                onTap: () {

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Uncomitted(
                                                valor1: post.COD_PESSOA.toString(),
                                                valor2: post.DES_PESSOA.toString(),
                                              )));

                                },
                                title: new Center(
                                    child: new Text(
                                      "COD_COMPANY: " + post.COD_PESSOA.toString(),
                                    )),
                                subtitle: new Center(
                                    child: new Text(
                                      "DES_COMPANY: " + post.DES_PESSOA.toString(),
                                    )),

                                /*new Text(
                                    "GRADE: " +
                                        post.des_grade +
                                        "\n SAFRA: " +
                                        post.crop.toString() +
                                        "\n COD.CLIENTE: " +
                                        post.cod_cliente.toString() +
                                        "\n SAMPLE: " +
                                        post.sample,
                                    textAlign: TextAlign.center))*/
                                /* title: Text( "Empresa: " + post.cod_empresa.toString() ),
                                  subtitle: Text("Carga: " + post.cod_carga.toString() + "\n Teste: 001" + "\n teste" + "\n teste"),*/
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider();
                            },
                          );
                        }
                        break;
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ]),
      ),
      ),


    ]),

    ),);
  }
}

/* FutureBuilder<List<Post>>(
        future: _recuperarPostagens(),
        builder:  (context, snapshot){

          switch( snapshot.connectionState ){
            case ConnectionState.none :
            case ConnectionState.waiting :
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active :
            case ConnectionState.done :
              if( snapshot.hasError ){
                print("lista: Erro ao carregar $snapshot");
              }else {

                print("lista: carregou!! ");
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index){

                      List<Post> lista = snapshot.data ?? <Post>[];
                      Post post = lista[index];

                      return ListTile(
                        title: Text( "Empresa: " + post.cod_empresa.toString() ),
                        subtitle: Text("Carga: " + post.cod_carga.toString() ),
                      );

                    }
                );

              }
              break;
          }
      return Container();
        },
      ),
    );
  }
}*/
