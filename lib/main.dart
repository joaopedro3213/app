import 'package:flutter/material.dart';
import 'package:myapp/telas/tela_planeta.dart';

import 'controle/controle_planetas.dart';
import 'modelos/planeta.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planetas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 99, 99, 246)),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'APP - PLANETAS',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incluirPlaneta(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaPlaneta(
          isIncluir: true,
          planeta: Planeta.vazio(),
        ),
      ),
    );
    _atualizarPlanetas(); // Atualiza a lista de planetas ao retornar
  }

  void _alterarPlaneta(BuildContext context, Planeta planeta) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TelaPlaneta(
            isIncluir: false,
                planeta: planeta,
              )),
    );
    _atualizarPlanetas(); // Atualiza a lista de planetas ao retornar
  }

  Future<void> _excluirPlaneta(int id) async {
    await _controlePlanetas.excluirPlaneta(id);
    _atualizarPlanetas();
  }

  final ControlePlanetas _controlePlanetas = ControlePlanetas();

  List<Planeta> _planetas = [];
  @override
  void initState() {
    super.initState();
    _atualizarPlanetas();
  }

  Future<void> _atualizarPlanetas() async {
    final resultado = await _controlePlanetas.lerPlanetas();
    setState(() {
      _planetas = resultado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _planetas.length,
        itemBuilder: (context, index) {
          final planeta = _planetas[index];
          return ListTile(
              title: Text(planeta.nome),
              subtitle: Text(planeta.apelido!),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _alterarPlaneta(context, planeta),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _excluirPlaneta(planeta.id!),
                  ),
                ],
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incluirPlaneta(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

