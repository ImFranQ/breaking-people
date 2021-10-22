import '../models/character.dart';
import '../services/character_service.dart';
import 'package:flutter/material.dart';

class CharactersList extends StatefulWidget{
  const CharactersList({Key? key}) : super(key: key);

  @override
  _CharactersListState createState() => _CharactersListState();
}


class _CharactersListState extends State<CharactersList> {
  late Future<List<Character>> futureCharacters;
  
  @override
  void initState() {
    super.initState();
    futureCharacters = CharacterService().getlAllCharacters();
  }
    
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: FutureBuilder<List<Character>>(
        future: futureCharacters,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.map<Widget>((data) => CharactersListItem(data)).toList(),
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

class CharactersListItem extends StatefulWidget {

  final Character data;

  const CharactersListItem(this.data, {Key? key}) : super(key: key);

  @override
  State<CharactersListItem> createState() => _CharactersListItemState();
}

class _CharactersListItemState extends State<CharactersListItem> {

  bool isFavorite = false;

  void toggleFavorite(){
    setState(() {
      isFavorite = !isFavorite;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    var tile = ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.data.img),
      ),
      title: Row(children: [
        Text(widget.data.name),
      ]),
      subtitle: Text(widget.data.portrayed),
      trailing: Text(widget.data.status),
    );

    var tileFooter = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: toggleFavorite, 
          icon: isFavorite
            ? const Icon(Icons.favorite, color: Colors.red)
            : const Icon(Icons.favorite, color: Colors.black26) 
        )
      ],
    );
    
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          tile,
          tileFooter
        ],
      ),
    );
  }
}