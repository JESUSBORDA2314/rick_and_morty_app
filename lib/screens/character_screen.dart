import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character_mode.dart';

class CharacterScreen extends StatelessWidget {
  final Character character;
  const CharacterScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      centerTitle: true,
      title:  Text(character.name!),
    ));
  }
}
