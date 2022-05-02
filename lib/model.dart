enum Sexo { MASCULINO, FEMININO }

Sexo? strToSexo(String? str){
  if (str == null){
    return null;
  }
  switch (str.toUpperCase()){
    case 'MASCULINO':
    case 'M':
      return Sexo.MASCULINO;
    case 'FEMININO':
    case 'F':
      return Sexo.FEMININO;
    default:
      return null;
  }
}

class Pessoa {
  String? nome;
  String? cpf;
  DateTime? nascimento;
  Sexo? sexo;

  Pessoa(this.nome, this.cpf, this.nascimento, this.sexo);

  Pessoa.fromMap(Map<String, String> map){
    nome = map['nome'];
    cpf = map['cpf'];
    nascimento = DateTime.tryParse(map['nascimento'] ?? '2000-01-01');
    sexo = strToSexo(map['sexo']);
  }

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

  Programador(String? nome, String? cpf, DateTime? nascimento, Sexo? sexo, this.salario) : super(nome, cpf, nascimento, sexo);

  Programador.fromMap(Map<String, String> map) : super.fromMap(map) {
    salario = double.tryParse(map['salario'] ?? "0.0");
  }

  @override
  String toString(){
    return "{nome='$nome', cpf='$cpf', nascimento=$nascimento, idade=${getIdade()}, sexo=$sexo, salario=$salario}";
  }
}

void mainEntidades(){

  final map = {
    'nome' : 'Bagual',
    'nascimento' : '2003-05-08',
    'sexo' : 'M',
    'salario' : "1000.0"
  };

  Pessoa pessoa = Pessoa.fromMap(map);


  // bool isBoss = false;
  // Programador prog = Programador();
  // prog.nome = "Joao";
  // prog.cpf = "095.523.274-33";
  // prog.nascimento = DateTime(2003,09,25);
  // prog.idade = 18;
  // prog.salario = isBoss ? 20000.0 : 5600.0;
  print(pessoa.toString());
}