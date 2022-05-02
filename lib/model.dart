enum Sexo { MASCULINO, FEMININO }

class Pessoa {
  String? nome;
  String? cpf;
  DateTime? nascimento;
  int? idade;

  int? getIdade(){
    if(nascimento == null){
      return null;
    }
    final hoje = DateTime.now();
    final idade = hoje.difference(nascimento!);
    return idade.inDays ~/ 365;
  }

  @override
  String toString(){
    return "{nome='$nome', cpf='$cpf', nascimento=$nascimento, idade=${getIdade()}, sexo=$Sexo.MASCULINO}";
  }
}

class Programador extends Pessoa{
  double? salario;

  @override
  String toString(){
    return "{nome='$nome', cpf='$cpf', nascimento=$nascimento, idade=${getIdade()}, sexo=$Sexo.MASCULINO, salario=$salario}";
  }
}

void mainEntidades(){
  Programador prog = Programador();
  prog.nome = "Joao";
  prog.cpf = "095.523.274-33";
  prog.nascimento = DateTime(2003,09,25);
  prog.idade = 18;
  prog.salario = 5600.0;
  print(prog.toString());
}