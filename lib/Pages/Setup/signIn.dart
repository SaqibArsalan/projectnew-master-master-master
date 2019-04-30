import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_app_firebase/Pages/Setup/timings.dart';
//import 'package:flutter_app_firebase/Pages/Setup/home.dart';
import 'package:project/Pages/Setup/timings.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                validator: (input) {

                  if(input.isEmpty) {
                    return 'Please type an email';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                    labelText: 'Email'
                ),
              ),

              TextFormField(
                validator: (input) {
                  if(input.length <0) {
                    return 'Your password should be 6 characters long';
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
                obscureText: true,
              ),
              RaisedButton(
                onPressed: signIn,
                child: Text('Sign in') ,
              ),


            ],
          )
      ),

    );
  }

  Future<void> signIn() async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();


      try{
         await  FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);

        Navigator.push(context,MaterialPageRoute(builder: (context) => namazTimings()));


      }
      catch(e) {
        print(e.message);

      }



    }





  }
}
