// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:breaking_bad_app/data/models/character.dart';
import 'package:breaking_bad_app/data/models/quote.dart';
import 'package:breaking_bad_app/data/repository/characters_repository.dart';

part 'breakingbad_state.dart';

class BreakingbadCubit extends Cubit<BreakingbadState> {
  final CharactersRepository charactersRepository;
  BreakingbadCubit(this.charactersRepository) : super(BreakingbadInitial());

  void sendCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(BreakingbadGetCharactersSuccessState(characters));
    });
  }

  void sendQuotes(String charName) {
    charactersRepository.getAllQuotes(charName).then((quotes) {
      emit(BreakingbadGetQuotesSuccessState(quotes));
    });
  }
}
