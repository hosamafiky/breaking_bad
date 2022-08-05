import 'package:breaking_bad_app/business_logic/cubit/breakingbad_cubit.dart';
import 'package:breaking_bad_app/constants/palette.dart';
import 'package:breaking_bad_app/data/models/character.dart';
import 'package:breaking_bad_app/presentation/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Character>? characters;

  late List<Character>? searchCharacters;

  bool isSearching = false;

  final searchController = TextEditingController();

  Widget buildSearchField() {
    return TextField(
      controller: searchController,
      cursorColor: Palette.kGrey,
      decoration: const InputDecoration(
        hintText: 'Find a character..',
        hintStyle: TextStyle(color: Palette.kGrey, fontSize: 18.0),
        border: InputBorder.none,
      ),
      style: const TextStyle(color: Palette.kGrey, fontSize: 18.0),
      onChanged: (textInput) {
        addSearchedItems(textInput);
      },
    );
  }

  void addSearchedItems(String text) {
    searchCharacters = characters!
        .where((character) => character.name.toLowerCase().startsWith(text))
        .toList();
    setState(() {});
  }

  Widget buildAppBarTitle() {
    if (isSearching) {
      return buildSearchField();
    } else {
      return const Text(
        'Characters',
        style: TextStyle(
          color: Palette.kGrey,
        ),
      );
    }
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          icon: const Icon(
            Icons.clear,
            color: Palette.kGrey,
          ),
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Palette.kGrey,
          ),
          onPressed: _startSearching,
        ),
      ];
    }
  }

  void _startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      searchController.clear();
    });
  }

  Widget buildBlocWidget() {
    return BlocBuilder<BreakingbadCubit, BreakingbadState>(
        builder: (context, state) {
      if (state is BreakingbadGetCharactersSuccessState) {
        characters = state.characters;
        return buildLoadedListWidget();
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Palette.kYellow,
          ),
        );
      }
    });
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: Palette.kGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemBuilder: (context, index) {
        return CharacterCard(
          character: searchController.text.isEmpty
              ? characters![index]
              : searchCharacters![index],
        );
      },
      itemCount: searchController.text.isEmpty
          ? characters!.length
          : searchCharacters!.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Palette.kGrey,
        ),
        backgroundColor: Palette.kYellow,
        title: buildAppBarTitle(),
        actions: buildAppBarActions(),
      ),
      body: buildBlocWidget(),
    );
  }
}
