enum Sexo { MASCULINO, FEMININO }

class Pessoa {
  String? nome;
  String? cpf;
  DateTime? nascimento;
  int? idade;
  double? salario;
  bool? programador;

  @override
  String toString(){
    return "{nome='$nome', cpf='$cpf', nascimento=$nascimento, idade=$idade, sexo=$Sexo.MASCULINO, salario=$salario, programador=$programador}";
  }
}

void mainEntidades(){
  Pessoa pessoa = Pessoa();
  pessoa.nome = "Joao";
  pessoa.cpf = "095.523.234-33";
  pessoa.nascimento = DateTime(2003,09,25);
  pessoa.idade = 18;
  pessoa.salario = 5600.0;
  pessoa.programador = true;
  print(pessoa.toString());
}