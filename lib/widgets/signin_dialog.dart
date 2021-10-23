// import 'package:breaking_people/services/auth_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class SiginDialog extends StatefulWidget{
  const SiginDialog({Key? key}) : super(key: key);

  @override
  _SiginDialogState createState() => _SiginDialogState();
}

class _SiginDialogState extends State<SiginDialog> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // late Future<UserCredential> user;

  void siginWithGoogle(){
    // user = AuthService().signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    var outlinedButton = OutlinedButton(
      onPressed: siginWithGoogle,
      child: const Text('Sign in with Google')
    );

    var dialog = Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Center(child: Text('You needs signed to add to favorites')),
              outlinedButton
            ]
          )
        ),
      )
    );

    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) return dialog;

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}