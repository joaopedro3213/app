class Planeta {
  int? id;
  String nome;
  double tamanho;
  double distancia;
  String? apelido;

  // Construtor principal
  Planeta({
    this.id,
    required this.nome,
    required this.tamanho,
    required this.distancia,
    this.apelido,
  });

  // Construtor alternativo (objeto vazio)
  Planeta.vazio()
      : id = null,
        nome = '',
        tamanho = 0.0,
        distancia = 0.0,
        apelido = null;

  // Converter de Map para objeto Planeta
  factory Planeta.fromMap(Map<String, dynamic> map) {
    return Planeta(
      id: map['id'],
      nome: map['nome'],
      tamanho: map['tamanho'].toDouble(), // Garante que seja double
      distancia: map['distancia'].toDouble(),
      apelido: map['apelido'],
    );
  }

  // Converter de objeto Planeta para Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'tamanho': tamanho,
      'distancia': distancia,
      'apelido': apelido,
    };
  }
}
