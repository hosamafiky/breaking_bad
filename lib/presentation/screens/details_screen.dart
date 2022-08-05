// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad_app/business_logic/cubit/breakingbad_cubit.dart';
import 'package:breaking_bad_app/constants/palette.dart';
import 'package:flutter/material.dart';

import 'package:breaking_bad_app/data/models/character.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character character;

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 550.0,
      pinned: true,
      backgroundColor: Palette.kGrey,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickname,
          style: const TextStyle(
            color: Palette.kWhite,
          ),
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: Palette.kWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          TextSpan(
              text: value,
              style: const TextStyle(
                color: Palette.kWhite,
                fontSize: 16.0,
              )),
        ],
      ),
    );
  }

  Widget _buildDivider(double endIndent) {
    return Divider(
      height: 30.0,
      color: Palette.kYellow,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Widget checkIfQuotesLoaded(BreakingbadState state) {
    if (state is BreakingbadGetQuotesSuccessState) {
      return displayRandomQuoteOrEmptyContainer(state);
    } else {
      return const SizedBox(
        height: 150.0,
        width: double.infinity,
        child: Center(
          child: CircularProgressIndicator(
            color: Palette.kYellow,
          ),
        ),
      );
    }
  }

  Widget displayRandomQuoteOrEmptyContainer(state) {
    var quotes = state.quotes;
    if (quotes.length != 0) {
      int randomIndex = Random().nextInt(quotes.length - 1);
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        width: double.infinity,
        height: 200.0,
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              TypewriterAnimatedText(quotes[randomIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.kGrey,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsetsDirectional.fromSTEB(
                      14.0, 14.0, 14.0, 0.0),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _characterInfo(
                        'Job : ',
                        character.jobs.join(" / "),
                      ),
                      _buildDivider(330.0),
                      _characterInfo(
                        'Appeared in : ',
                        character.category,
                      ),
                      _buildDivider(265.0),
                      if (character.appearance.isNotEmpty) ...[
                        _characterInfo(
                          'Seasons : ',
                          character.appearance.join(" / "),
                        ),
                        _buildDivider(290.0),
                      ],
                      _characterInfo(
                        'Status : ',
                        character.status,
                      ),
                      _buildDivider(310.0),
                      _characterInfo(
                        'Actor/Actress : ',
                        character.actorName,
                      ),
                      _buildDivider(250.0),
                      if (character.betterCallSaulAppearance.isNotEmpty) ...[
                        _characterInfo(
                          'Better Call Saul Seasons : ',
                          character.betterCallSaulAppearance.join(" / "),
                        ),
                        _buildDivider(160.0),
                      ],
                      BlocBuilder<BreakingbadCubit, BreakingbadState>(
                        builder: (context, state) {
                          return checkIfQuotesLoaded(state);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
