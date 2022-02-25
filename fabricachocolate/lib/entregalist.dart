import 'package:fabricachocolate/services/api_service.dart';
import 'package:flutter/material.dart';

import 'detailwidget.dart';
import 'models/entregas.dart';

class EntregaList extends StatelessWidget {
  final List<Entregas> entregas;
  static const IconData local_shipping =
      IconData(0xe3a6, fontFamily: 'MaterialIcons');
  static const IconData egg = IconData(0xf0311, fontFamily: 'MaterialIcons');
  final Function funcao;
  EntregaList({Key key, this.entregas, this.funcao}) : super(key: key);

  ApiService api = new ApiService();

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
              trailing: IconButton(
                icon: Icon(local_shipping, size: 25),
                onPressed: () {
                  _onClickDialog(context, entregas[index]);
                },
              ),
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
            content: Text("Deseja marcar o pedido do cliente: " +
                entregas.nome +
                "\nTel:" +
                entregas.numero +
                "\n\nComo entregue?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Sim"),
                onPressed: () {
                  print("ENTROU O ID: " + entregas.id);
                  Navigator.pop(context);
                  api.updateEntregas(entregas.id);
                  funcao();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
