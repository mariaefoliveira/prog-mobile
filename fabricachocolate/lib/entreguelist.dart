import 'package:fabricachocolate/services/api_service.dart';
import 'package:flutter/material.dart';

import 'detailwidget.dart';
import 'models/entregas.dart';

class EntregueList extends StatelessWidget {
  final List<Entregas> entregas;
  EntregueList({Key key, this.entregas}) : super(key: key);
  static const IconData egg = IconData(0xf0311, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: entregas == null ? 0 : entregas.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: Icon(egg, size: 35),
              title: Text(entregas[index].nome),
              subtitle: Text(entregas[index].tipoOvo.toString()),
              trailing: Icon(Icons.info),
              onTap: () {
                _onClickDialog(context, entregas[index]);
              },
            ),
          );
        }); //Forma o formato da listagem
  }

  _onClickDialog(BuildContext context, Entregas entregas) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            //title: Text("Entrega do Pedido: "),
            //content: Text("Deseja marcar pedido como entregue?"),
            title: Text("Entrega do pedido do cliente: " + entregas.nome),
            content: Text("Cliente: " +
                entregas.nome +
                "\n\nTipo do Pedido: " +
                entregas.tipoOvo +
                "\n\nTel:" +
                entregas.numero),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
