import 'package:breaking_people/models/character.dart';
import 'package:breaking_people/services/auth_service.dart';
import 'package:breaking_people/widgets/signin_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CharactersListItem extends StatefulWidget {

  final Character data;

  const CharactersListItem(this.data, {Key? key}) : super(key: key);

  @override
  State<CharactersListItem> createState() => _CharactersListItemState();
}

class _CharactersListItemState extends State<CharactersListItem> {

  bool isFavorite = false;

  GoogleSignInAccount? _currentUser;

  void toggleFavorite(){

    // open sign in dialog if an user is not signed
    if(_currentUser == null){
      showDialog(
        context: context, 
        builder: (BuildContext context){
          return const SiginDialog();
        }
      );
      
      return;
    }
    
    setState(() {
      isFavorite = !isFavorite;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text((isFavorite ? 'Added' : 'Removed') + ' to favorites.'), 
          duration: const Duration(seconds: 1),
        )
      );
    });
  }

  @override
  void initState() {
    super.initState();

    // watch user signed state   
    AuthService().googleSignIn().onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });

    AuthService().googleSignIn().signInSilently();
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
      trailing: Chip(label: Text(widget.data.status)),
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