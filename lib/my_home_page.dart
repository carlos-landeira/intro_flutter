import 'package:flutter/material.dart';
import 'package:intro_flutter/model.dart';
import 'package:intro_flutter/fiscal.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _incrementando = true;
  int _contador = 0;
  List<int> _historico = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      drawer: buildDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Contador:',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              '$_contador',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 20.0),
            const Text('Histórico:',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20.0),
            Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: Text(_historico.join(', '),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25.0, color: Colors.grey.shade600))),
            const SizedBox(height: 20.0),
            const Text('Total:',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20.0),
            Text('${_somarHistorico()}',
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementar,
        tooltip: 'Increment',
        child: _incrementando ? Icon(Icons.add) : Icon(Icons.remove),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.clear),
              title: const Text('Zerar Contador'),
              onTap: _zerar),
          ListTile(
            leading: const Icon(Icons.swap_calls),
            title: const Text('Inverter Contador'),
            onTap: _inverter,
          ),
          ListTile(
              leading: const Icon(Icons.memory),
              title: const Text("Memorizar Contador"),
              onTap: _memorizar)
        ]
      )
    );
  }

  void _incrementar() {
    setState(() {
      if (_incrementando == true) {
        _contador++;
      } else {
        _contador--;
      }
    });
    // mainEntidades();
    // mainNF();
  }

  void _zerar() {
    Navigator.of(context).pop();
    setState(() {
      _contador = 0;
    });
  }

  void _inverter() {
    Navigator.of(context).pop();
    setState(() {
      _incrementando = !_incrementando;
    });
  }

  void _memorizar() {
    Navigator.of(context).pop();
    setState(() {
      _historico.add(_contador);
    });
  }

  int _somarHistorico() {
    if (_historico.isEmpty) {
      return 0;
    } else {
      return _historico.reduce((a, b) => a + b);
    }
  }
}
