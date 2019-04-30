import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:project/Pages/Setup/signIn.dart';
import 'package:project/Pages/Setup/timings.dart';
//
//void main()=> runApp(new MaterialApp(
//  home: new HomePage(),
//));
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var convertResponseToJson;
  static var currentTimeStamp=DateTime.now().millisecondsSinceEpoch.toString();
  final String url="http://api.aladhan.com/v1/timings/"+currentTimeStamp+"?latitude=51.508515&longitude=-0.1254872&method=2";
  var data;
  var temp;

  Future<String> getJsonData()async{
    var response=await http.get(
      Uri.encodeFull(url), // to remove spaces etc from the url.
      headers: {"Accept":"application/json"} , //only accept json response.
    );
    print(response.body);
    setState((){
      convertResponseToJson=jsonDecode(response.body);
      data=convertResponseToJson['data'];
      temp=data['timings'];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    getJsonData();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("HTTP GET JSON"),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RichText(text: TextSpan(text: "Fajr: "+temp['Fajr'],style: DefaultTextStyle.of(context).style)),
                new RichText(text: TextSpan(text: "Dhuhr: "+temp['Dhuhr'],style: DefaultTextStyle.of(context).style)),
                new RichText(text: TextSpan(text: "Asr"
                    ": "+temp['Asr'],style: DefaultTextStyle.of(context).style)),
                new RichText(text: TextSpan(text: "Maghrib: "+temp['Maghrib'],style: DefaultTextStyle.of(context).style)),
                new RichText(text: TextSpan(text: "Isha: "+temp['Isha'],style: DefaultTextStyle.of(context).style)),

                RaisedButton(
                  child: Text('Launch compass'),
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => namazTimings()));
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}