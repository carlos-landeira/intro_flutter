import 'package:intro_flutter/model.dart';

class Pessoa {
  String? nome;
  String? cpf;
  DateTime? nascimento;
  Sexo? sexo;

  Pessoa({this.nome, this.cpf, this.nascimento, this.sexo});
}

class NotaFiscal {
  List<ItemNF> itens = [];
  int? numero;
  DateTime? emissao;
  Pessoa? cliente;
  String? endereco;

  NotaFiscal({this.emissao, this.cliente, this.endereco, this.numero});

  double calcularValorTotal() {
    return itens.map((e) => e.getValorTotal()).reduce((a, b) => a + b);
  }

  double? calcularTotalDescontos() {
    return itens.map((e) => e.desconto).reduce((a, b) => a + b);
  }

  double calcularTotalAcrescimos() {
    return itens.map((e) => e.acrescimo).reduce((a, b) => a + b);
  }

  bool possuiDesconto(){
    return itens.any((i) => i.desconto > 0 ? true : false);
  }

  List<ItemNF> itensComDesconto(){
    return itens.where((i) => i.desconto > 0).toList();
  }

  String getStrItens() {
    return itens.map((i) => "${i.numSeq}: ${i.produto}").join(", ");
  }

  ItemNF? getProdutoMaisBarato() {
    ItemNF? itemBarato;
    for (ItemNF item in itens) {
      if (itemBarato == null) {
        itemBarato = item;
      } else if (item.getValorTotal() < itemBarato.getValorTotal()) {
        itemBarato = item;
      }
    }
    return itemBarato;
  }

  ItemNF? getProdutoMaisCaro() {
    ItemNF? itemCaro;
    for (ItemNF item in itens) {
      if (itemCaro == null) {
        itemCaro = item;
      } else if (item.getValorTotal() > itemCaro.getValorTotal()) {
        itemCaro = item;
      }
    }
    return itemCaro;
  }

  ItemNF addItem(
      {required String produto,
      required double valor,
      double desconto = 0.0,
      double acrescimo = 0.0}) {
    if (valor == 0.0) {
      throw Exception('Valor não pode ser zero');
    }
    if (produto == '') {
      throw Exception("Produto precisa ser informado");
    }
    ItemNF item = ItemNF(
        numSeq: itens.length + 1,
        produto: produto,
        valor: valor,
        desconto: desconto,
        acrescimo: acrescimo);
    itens.add(item);
    return item;
  }
}

class ItemNF {
  int numSeq;
  String produto;
  double valor;
  double desconto;
  double acrescimo;

  ItemNF(
      {required this.numSeq,
      required this.produto,
      required this.valor,
      this.desconto = 0.0,
      this.acrescimo = 0.0});

  double getValorTotal() => valor + acrescimo - desconto;

  @override
  String toString() {
    return '{numSeq=$numSeq, produto=$produto, valor=$valor, desconto=$desconto, acrescimo=$acrescimo}';
  }
}

void mainNF() {
  final pessoa = Pessoa(nome: 'Carlos');
  final nota = NotaFiscal(
      cliente: pessoa,
      emissao: DateTime(2022, 4, 6),
      endereco: "Rua A",
      numero: 546);
  nota.addItem(produto: 'Caderno', valor: 25.0, desconto: 10.0);
  nota.addItem(produto: 'Lanterna', valor: 15.0);
  nota.addItem(produto: 'Caneta', valor: 2.0);
  print('Total: ${nota.calcularValorTotal()}');
  print('desconto: ${nota.calcularTotalDescontos()}');
  print('Mais barato: ${nota.getProdutoMaisBarato()}');
  print('Mais caro: ${nota.getProdutoMaisCaro()}');
}
