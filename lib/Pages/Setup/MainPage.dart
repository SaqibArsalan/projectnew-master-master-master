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



class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Pro Masjid Finder"),
        centerTitle: true,
      ),
       body: Center(
         child: Container(
           child:
           new RaisedButton(
             onPressed: null,
             child: Text("Prayer Timings"),

           ),

         ),

       )


    );
  }
}

