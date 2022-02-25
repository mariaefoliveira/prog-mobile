import 'dart:convert';

import 'package:fabricachocolate/models/entregas.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ApiService {
  final String apiUrl =
      "http://192.168.1.104:8081/fabricadechocolate-api/api/v1/pedido";

  Future<List<Entregas>> entregar() async {
    Response res = await get('$apiUrl/entregar');

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Entregas> entregas =
          body.map((dynamic item) => Entregas.fromJson(item)).toList();
      return entregas;
    } else if (res.statusCode == 404) {
      return [];
    } else {
      throw "Falha ao carregar a lista de pedidos a serem entregues";
    }
  }

  Future<List<Entregas>> entregue() async {
    Response res = await get('$apiUrl/entregue');

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Entregas> entregas =
          body.map((dynamic item) => Entregas.fromJson(item)).toList();
      return entregas;
    } else {
      throw "Falha ao carregar a lista de pedidos entregues";
    }
  }

  Future<Entregas> updateEntregas(String id) async {
    Response response = await put('$apiUrl/$id/entregar-pedido');
    if (response.statusCode == 200) {
      return Entregas.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao atualizar a entrega');
    }
  }
}
