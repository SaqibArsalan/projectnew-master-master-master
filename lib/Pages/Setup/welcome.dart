import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_app_firebase/Pages/Setup/googleMaps.dart';
//import 'package:flutter_app_firebase/Pages/Setup/retrieveData.dart';
//import 'package:flutter_app_firebase/Pages/Setup/signIn.dart';
//import 'package:flutter_app_firebase/Pages/Setup/sign_up.dart';
import 'package:geodesy/geodesy.dart';
//import 'package:flutter_app_firebase/Pages/Setup/timings.dart';
import 'package:project/Pages/Setup/retrieveData.dart';
import 'package:project/Pages/Setup/signIn.dart';
import 'package:project/Pages/Setup/timings.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
          title: Text("My Firebase app"),
          centerTitle: true,
          backgroundColor: Colors.brown[800]
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          RaisedButton(
            onPressed: navigateToSignIn,
            child: Text('Sign in'),
            color: Colors.black,
            textTheme: ButtonTextTheme.accent,
          ),
          RaisedButton(
            onPressed: navigateToSignUp,
            child: Text('Sign Up') ,
            color: Colors.black,
            textTheme: ButtonTextTheme.accent,
          )
        ],
      ),


    );
  }

  void navigateToSignIn() {
    Navigator.push(context,MaterialPageRoute(builder: (context) => namazTimings(), fullscreenDialog: true));


  }


  void navigateToSignUp() {
    Navigator.push(context,MaterialPageRoute(builder: (context) => retrieveData(), fullscreenDialog: true));



  }






}
