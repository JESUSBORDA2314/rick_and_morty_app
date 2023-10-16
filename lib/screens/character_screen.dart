import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/models/character_mode.dart';
import 'package:rick_and_morty_app/models/episode_mode.dart';
import 'package:rick_and_morty_app/providers/api_providers.dart';

class CharacterScreen extends StatelessWidget {
  final Character character;
  const CharacterScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(character.name!),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.35,
              width: double.infinity,
              child: Hero(
                tag: character.id!,
                child: Image.network(
                  character.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: size.height * 0.14,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CardData("Status", character.status!),
                  CardData("Origin", character.species!),
                  CardData("Specie", character.origin!.name!)
                ],
              ),
            ),
            Text(
              "Episodes",
              style: TextStyle(fontSize: 17),
            ),
            EpisodeList(size: size, character: character)
          ],
        ),
      ),
    );
  }

  Widget CardData(String texto1, String texto2) {
    return Expanded(
        child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Text(texto1),
          Text(
            texto2,
            style: TextStyle(overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    ));
  }
}

class EpisodeList extends StatefulWidget {
  const EpisodeList({super.key, required this.size, required this.character});

  final Size size;
  final Character character;
  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getEpisodes(widget.character);
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    return SizedBox(
      height: widget.size.height * 0.35,
      child: ListView.builder(
        itemCount: apiProvider.episodes.length,
        itemBuilder: (context, index) {
          final episode = apiProvider.episodes[index];
          return ListTile(
            leading: Text(episode.episode!),
            title: Text(episode.name!),
            trailing: Text(episode.airDate!),
          );
        },
      ),
    );
  }
}
