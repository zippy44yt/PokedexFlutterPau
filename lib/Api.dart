import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Pokemon.dart';

class API {
  static const String baseUrl = 'https://pokeapi.co/api/v2/pokemon?limit=20';

  static Future<List<Pokemon>> fetchPokemon() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Pokemon> pokemonList = [];

        for (var item in data['results']) {
          final pokemonResponse = await http.get(Uri.parse(item['url']));
          if (pokemonResponse.statusCode == 200) {
            final pokemonData = jsonDecode(pokemonResponse.body);
            pokemonList.add(Pokemon.fromJson(pokemonData));
          }
        }
        return pokemonList;
      } else {
        throw Exception('Error al cargar los Pokémon');
      }
    } catch (e) {
      throw Exception('Error en la conexión: $e');
    }
  }
}
