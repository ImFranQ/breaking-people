import 'package:flutter/material.dart';

class CharacterSearch extends StatefulWidget {
  const CharacterSearch({Key? key}) : super(key: key);

  @override
  State<CharacterSearch> createState() => _CharacterSearchState();
}

class _CharacterSearchState extends State<CharacterSearch>{
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        labelText: 'Search character',
        prefixIcon: Icon(Icons.search)
      ),
      onChanged: (String value){

      },
    );
  }
}
