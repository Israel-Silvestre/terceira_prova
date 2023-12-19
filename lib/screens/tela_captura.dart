import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TelaCaptura extends StatefulWidget {
  @override
  _TelaCapturaState createState() => _TelaCapturaState();
}

class _TelaCapturaState extends State<TelaCaptura> {
  List<int> numerosSorteados = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Captura'),
      ),
      body: FutureBuilder(
        future: _verificarConectividade(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == false) {
            return Center(
              child: Text('Sem conexão com a internet'),
            );
          } else {
            return _buildListView();
          }
        },
      ),
    );
  }

  Future<bool> _verificarConectividade() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return FutureBuilder(
          future: _getPokemonData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao obter dados do Pokémon'),
              );
            } else {
              var pokemon = snapshot.data?[index];
              return _buildPokemonItem(pokemon);
            }
          },
        );
      },
    );
  }

  Widget _buildPokemonItem(Map<String, dynamic>? pokemon) {
    // Verifique se o Pokémon é nulo
    if (pokemon == null) {
      return Container(); // Ou qualquer outro widget para representar um caso nulo
    }

    bool capturado = false; // Verifique se o Pokémon já foi capturado
    // Lógica para verificar se o Pokémon já foi capturado pode ser implementada aqui

    return ListTile(
      title: Text(pokemon['name'] ?? ''),
      subtitle: Text('ID: ${pokemon['id'] ?? ''}'),
      trailing: ElevatedButton(
        onPressed: capturado ? null : () => _capturarPokemon(pokemon),
        child: Icon(Icons.sports_baseball),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            capturado ? Colors.grey : Colors.red,
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _getPokemonData() async {
    List<int> idsSorteados = [];

    // Sorteie 6 números de 0 até 1017
    var random = Random();
    while (idsSorteados.length < 6) {
      var idSorteado = random.nextInt(1018);
      if (!idsSorteados.contains(idSorteado)) {
        idsSorteados.add(idSorteado);
      }
    }

    // Salve os números sorteados
    numerosSorteados = idsSorteados;

    // Obtenha os dados de todos os Pokémons
    List<Future<Map<String, dynamic>>> futures = [];
    for (var id in idsSorteados) {
      var url = 'https://pokeapi.co/api/v2/pokemon/$id/';
      futures.add(_fetchPokemonData(url));
    }

    return await Future.wait(futures);
  }

  Future<Map<String, dynamic>> _fetchPokemonData(String url) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao obter dados do Pokémon');
    }
  }

  void _capturarPokemon(Map<String, dynamic> pokemon) {
    // Implemente a lógica de captura e salvamento no banco de dados aqui
    // Você pode usar o Floor para salvar os dados no banco de dados local
    // Certifique-se de verificar se o Pokémon já foi capturado antes de salvar
  }
}
