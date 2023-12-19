// main.dart
import 'package:flutter/material.dart';
import 'package:terceira_prova/database/app_database.dart';
import 'tela_captura.dart'; // Importe o arquivo tela_captura.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialize o banco de dados Floor
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(MyApp(database));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;

  const MyApp(this.database);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaHome(database),
    );
  }
}

class TelaHome extends StatelessWidget {
  final AppDatabase database;

  const TelaHome(this.database);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('terceira_prova'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Informações sobre o aplicativo',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar para a TelaCaptura
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaCaptura(),
                  ),
                );
              },
              child: Text('Ir para TelaCaptura'),
            ),
          ],
        ),
      ),
    );
  }
}
