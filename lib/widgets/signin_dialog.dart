import 'package:breaking_people/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SiginDialog extends StatefulWidget{
  const SiginDialog({Key? key}) : super(key: key);

  @override
  _SiginDialogState createState() => _SiginDialogState();
}

class _SiginDialogState extends State<SiginDialog> {

  GoogleSignInAccount? _currentUser;
  
  void siginWithGoogle() {
    setState(() async {
      _currentUser = await AuthService().signInWithGoogle();
    });
  }

  @override
  void initState() {
    super.initState();
    
    AuthService().googleSignIn().onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });

    AuthService().googleSignIn().signInSilently();
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
              _currentUser == null ? outlinedButton : Text(_currentUser?.displayName ?? '')
            ]
          )
        ),
      )
    );

    return dialog;
  }
}