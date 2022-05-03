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

  double? calcularValorTotal() {
    double total = 0.0;
    for (int i = 0; i < itens.length; i++) {
      total += itens[i].getValorTotal();
    }
    return total;
  }

  double? calcularTotalDescontos() {
    double descontos = 0.0;
    for (int i = 0; i < itens.length; i++) {
      descontos += itens[i].desconto;
    }
    return descontos;
  }

  double? calcularTotalAcrescimos() {
    double acrescimos = 0.0;
    for (int i = 0; i < itens.length; i++) {
      acrescimos += itens[i].acrescimo;
    }
    return acrescimos;
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
  nota.addItem(produto: 'Caderno', valor: 25.0);
  nota.addItem(produto: 'Lanterna', valor: 15.0);
  nota.addItem(produto: 'Caneta', valor: 2.0);
  print('Total: ${nota.calcularValorTotal()}');
  print(nota.calcularTotalDescontos());
  print('Mais barato: ${nota.getProdutoMaisBarato()}');
  print('Mais caro: ${nota.getProdutoMaisCaro()}');
}