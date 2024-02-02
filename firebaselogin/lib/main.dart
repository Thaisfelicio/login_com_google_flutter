
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:googleapis/people/v1.dart';
import 'package:google_sign_in/google_sign_in.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[PeopleServiceApi.contactsReadonlyScope]);
  GoogleSignInAccount? _user;

  Future<void> _handleSignIn() async {
    try 
    {
      final user = await _googleSignIn.signIn();
      if(user != null) 
      {
        setState(() {
          _user = user;
        });
      }
    } 
    catch (error) 
    {
      print(error);
    }
  }

  
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In Teste'),
      ),
      body: Column(
        children: [
          Center(
          child: ElevatedButton(
            onPressed: _handleSignIn,
            child: Text('Sign in with Google'),
          ),
        ),
         if(_user != null)
          Column(
            children: [
              Text('${_user!.displayName ?? 'Usuário desconhecido'} log-in com sua conta google',
                style: TextStyle(fontSize: 40),
              ),
              
              const Icon(Icons.thumb_up_alt_rounded, color: Colors.brown,)
            ],
          ),
        ],
      )
    );
  }
}

