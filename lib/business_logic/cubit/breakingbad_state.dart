part of 'breakingbad_cubit.dart';

abstract class BreakingbadState {}

class BreakingbadInitial extends BreakingbadState {}

class BreakingbadGetCharactersSuccessState extends BreakingbadState {
  final List<Character> characters;

  BreakingbadGetCharactersSuccessState(this.characters);
}

class BreakingbadGetQuotesSuccessState extends BreakingbadState {
  final List<Quote> quotes;

  BreakingbadGetQuotesSuccessState(this.quotes);
}
