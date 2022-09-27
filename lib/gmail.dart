import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Gmail extends StatefulWidget {
  const Gmail({Key? key}) : super(key: key);

  @override
  _Gmail createState() => _Gmail();
}

class _Gmail extends State<Gmail> {
  FirebaseAuth? auth = FirebaseAuth.instance;
  GoogleSignIn? googleSignIn = GoogleSignIn();

  Future<void> signIn() async {
    GoogleSignInAccount? account = await googleSignIn!.signIn();
    GoogleSignInAuthentication? authentication = await account?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: authentication?.idToken,
        accessToken: authentication?.accessToken);
    final user = (await auth!.signInWithCredential(credential)).user;
    if (user != null) {
      print("Last result");
      print("${user}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  signIn();
                },
                child: const Text(
                  "SignIn with Google",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await googleSignIn!.signOut();
                  print("Last result");
                  print("success");
                },
                child: const Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
    );
  }
}