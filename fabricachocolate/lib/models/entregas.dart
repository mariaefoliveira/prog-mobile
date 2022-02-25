class Entregas {
  final String id;
  final String nome;
  final String tipoOvo;
  final String numero;
  final String statusEntrega;

  Entregas({
    this.id,
    this.nome,
    this.tipoOvo,
    this.numero,
    this.statusEntrega,
  });

  factory Entregas.fromJson(Map<String, dynamic> json) => Entregas(
        id: (json['id'] as int).toString(),
        nome: json['nome'] as String,
        tipoOvo: json['tipoOvo'] as String,
        numero: json['numero'] as String,
        statusEntrega: (json['statusEntrega'] as bool).toString(),
      );

  @override
  String toString() {
    return 'Trans{nome: $nome, tipoOvo:$tipoOvo,numero:$numero}';
  }
}
