import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/models/character_mode.dart';
import 'package:rick_and_morty_app/providers/api_providers.dart';

class SearchCharacter extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    //Esto es lo que esta a la derecha
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //Esto es lo que esta a la izquierda
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final characterProvider = Provider.of<ApiProvider>(context);
    Widget circleLoading() {
      return Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage('assets/image/rick-and-morty-portal.gif'),
        ),
      );
    }

    if (query.isEmpty) {
      return circleLoading();
    }
    return FutureBuilder(
        future: characterProvider.getCharacter(query),
        builder: (context, AsyncSnapshot<List<Character>> snapshot) {
          if (!snapshot.hasData) {
            return circleLoading();
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final character = snapshot.data![index];
              return ListTile(
                onTap: () {
                  context.go('/character', extra: character);
                },
                title: Text(character.name!),
                leading: Hero(
                    tag: character.id!,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(character.image!),
                    )),
              );
            },
          );
        });
  }
}
