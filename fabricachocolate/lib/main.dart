import 'package:fabricachocolate/services/api_service.dart';
import 'package:flutter/material.dart';

import 'adddatawidget.dart';
import 'entregalist.dart';
import 'entreguelist.dart';
import 'models/entregas.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.brown, //Cor da barra de ferramentas
        primaryColor: const Color(0xFF795548),
        accentColor: const Color(0xFF795548),
        canvasColor: const Color(0xFFfafafa),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: new MyHomePage(
        title: "Entrega de Pedidos",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService api = ApiService();
  List<Entregas> listaDeEntrega;
  List<Entregas> listaDeEntregues;

  @override
  Widget build(BuildContext context) {
    if (listaDeEntrega == null) {
      listaDeEntrega = List<Entregas>();
    }
    if (listaDeEntregues == null) {
      listaDeEntregues = List<Entregas>();
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.brown, //cor do tab
                  title: Text(
                    "Fábrica de Chocolate",
                  ),
                  bottom: TabBar(
                    indicatorColor: Colors.yellow.shade200, //Barra indicadora
                    tabs: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.library_books),
                          Text("   Entregas Pendentes")
                        ],
                      ), //Entregas
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.history),
                          Text("   Histórico")
                        ],
                      ), //O que já foi entregue
                    ],
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    FutureBuilder(
                        future: loadListEntrega(),
                        builder: (context, snapshot) {
                          //(context, AsyncSnapshot<List<Entregas>> snapshot) {
                          //if (!snapshot.hasData) {
                          //return Center(child: CircularProgressIndicator());
                          //}

                          print("feature builder");
                          print(snapshot.connectionState);

                          return listaDeEntrega.length > 0
                              ? new EntregaList(
                                  entregas: listaDeEntrega, funcao: _getData)
                              : new Center(
                                  child: new Text("Nenhum registro encontrado!",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6));
                        }),
                    FutureBuilder(
                        future: loadListEntregues(),
                        builder: (context, snapshot) {
                          //(context, AsyncSnapshot<List<Entregas>> snapshot) {
                          //if (!snapshot.hasData) {
                          //return Center(child: CircularProgressIndicator());
                          //}

                          return listaDeEntregues.length > 0
                              ? new EntregueList(entregas: listaDeEntregues)
                              : new Center(
                                  child: new Text("Nenhum registro encontrado!",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6)); //Center
                        })
                  ],
                ))));
  }

  Future<List<Entregas>> loadListEntrega() async {
    print("load list");
    Future<List<Entregas>> futureEntregas = api.entregar();
    futureEntregas.then((listaDeEntrega) {
      print("setState");
      this.listaDeEntrega = listaDeEntrega;
    });
    return futureEntregas;
  }

//Adicionado 15/02/2022
  Future<List<Entregas>> loadListEntregues() async {
    print("load list");
    Future<List<Entregas>> futureEntregues = api.entregue();
    futureEntregues.then((listaDeEntregues) {
      this.listaDeEntregues = listaDeEntregues;
    });
    return futureEntregues;
  }

  Future<void> _getData() async {
    setState(() {
      loadListEntrega();
      //Adicionado 15/02/2022
      loadListEntregues();
    });
  }

  @override
  void initState() {
    super.initState();
    loadListEntrega();
    //Adicionado 15/02/2022
    loadListEntregues();
  }

  _navigateToAddScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDataWidget()),
    );
  }
}
