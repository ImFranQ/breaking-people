import 'package:breaking_people/models/character.dart';
import 'package:breaking_people/services/character_service.dart';
import 'package:breaking_people/widgets/character_list_item.dart';
import 'package:breaking_people/widgets/character_search.dart';
import 'package:flutter/material.dart';

class CharactersList extends StatefulWidget{
  const CharactersList({Key? key}) : super(key: key);

  @override
  _CharactersListState createState() => _CharactersListState();
}


class _CharactersListState extends State<CharactersList> {
  late Future<List<Character>> futureCharacters;

  String searchTerm = '';

  @override
  void initState() {
    super.initState();
    futureCharacters = CharacterService().getlAllCharacters();
  }

  void onSearch(String value){
    setState(() {
      searchTerm = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: FutureBuilder<List<Character>>(
        future: futureCharacters,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                Padding(padding: const EdgeInsets.all(10.0), child: CharacterSearch(onSearch)),
                ...snapshot.data!
                  .where((data) => data.name.toLowerCase().contains(searchTerm.toLowerCase()))
                  .map<Widget>((data) => CharactersListItem(data))
                  .toList()
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
