import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_app_firebase/Pages/Setup/retrieveData.dart';
import 'package:project/Pages/Setup/signIn.dart';
//import 'package:flutter_app_firebase/Pages/Setup/signIn.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: Column(
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
                onPressed: signUp,
                child: Text('Sign Up') ,
              ),

            ],
          )
      ),

    );
  }

  void signUp() async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();


      try{
        //FirebaseUser user = await  FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);

        await  FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);

        //user.sendEmailVerification();


        // Navigator.of(context).pop();

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));


      }
      catch(e) {
        print(e.message);

      }



    }

  }
}
