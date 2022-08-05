import 'package:breaking_bad_app/business_logic/cubit/breakingbad_cubit.dart';
import 'package:breaking_bad_app/constants/strings.dart';
import 'package:breaking_bad_app/data/models/character.dart';
import 'package:breaking_bad_app/data/repository/characters_repository.dart';
import 'package:breaking_bad_app/data/web_services/characters_web_services.dart';
import 'package:breaking_bad_app/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late BreakingbadCubit breakingbadCubit;
  late CharactersRepository charactersRepository;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    breakingbadCubit = BreakingbadCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                breakingbadCubit..sendCharacters(),
            child: const HomeScreen(),
          ),
        );
      case detailsRoute:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => BreakingbadCubit(charactersRepository)
              ..sendQuotes(character.name),
            child: DetailsScreen(
              character: character,
            ),
          ),
        );
    }
    return null;
  }
}
