
import 'package:breaking_people/widgets/character_widgets.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Breaking Bad Characters')),
        body: const CharactersList(),
      ),
    );
  }
}
