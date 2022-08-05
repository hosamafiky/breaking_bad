import 'package:breaking_bad_app/constants/palette.dart';
import 'package:breaking_bad_app/constants/strings.dart';
import 'package:breaking_bad_app/data/models/character.dart';
import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({Key? key, required this.character}) : super(key: key);

  final Character character;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Palette.kWhite,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: GridTile(
        footer: InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            detailsRoute,
            arguments: character,
          ),
          child: Hero(
            tag: character.id,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              color: Colors.black45,
              alignment: Alignment.bottomCenter,
              child: Text(
                character.name,
                style: const TextStyle(
                  color: Palette.kWhite,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
            ),
          ),
        ),
        child: Container(
          color: Palette.kGrey,
          child: character.imageUrl.isNotEmpty
              ? FadeInImage.assetNetwork(
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: 'assets/images/loading.gif',
                  image: character.imageUrl,
                  fit: BoxFit.cover,
                )
              : Image.asset('assets/images/placeholder.jpg'),
        ),
      ),
    );
  }
}
