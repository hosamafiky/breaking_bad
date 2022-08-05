import 'package:breaking_bad_app/data/models/character.dart';
import 'package:breaking_bad_app/data/models/quote.dart';
import 'package:breaking_bad_app/data/web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.fetchCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<Quote>> getAllQuotes(String charName) async {
    final quotes = await charactersWebServices.fetchQuotes(charName);
    return quotes.map((quote) => Quote.fromJson(quote)).toList();
  }
}
