import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
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


  var temp;
  var t2;
  var t3;
  var t4;
  var t5;
 Future getJsonData()async{
    var convertResponseToJson;
    var currentTimeStamp=new DateTime.now().toUtc().millisecondsSinceEpoch.toString();
    final String url="http://api.aladhan.com/v1/timings/"+"1557151854"+"?latitude=24.773&longitude=67.0762&method=1";
    var data;
    var response=await http.get(
      Uri.encodeFull(url), // to remove spaces etc from the url.
      headers: {"Accept":"application/json"} , //only accept json response.
    );
  //  print(response.body);
    setState((){
      convertResponseToJson=jsonDecode(response.body);
      data=convertResponseToJson['data'];
      temp=data['timings'];
      t2=data['date'];
      t3=t2['hijri'];
      t4=t3['month'];
      t5=t2['year'];
    });

  }

  @override
  Widget build(BuildContext context) {
    getJsonData();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Pro Masjid Finder"),
          backgroundColor: Colors.brown[700],

        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(25.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    new RichText(text: TextSpan(text: "Month Number: "+t4['number'].toString(),style: TextStyle(color: Colors.brown,fontSize: 30))),
                    new RichText(text: TextSpan(text: "Month : "+t4['ar'].toString()+t3['day'].toString(),style: TextStyle(color: Colors.brown,fontSize: 30))),
                    new RichText(text: TextSpan(text: "Year: "+t3['year'].toString(),style: TextStyle(color: Colors.brown,fontSize: 30))),
                    new RichText(text: TextSpan(text: "Fajr: "+temp['Fajr'],style: TextStyle(color: Colors.brown,fontSize: 30))),
                    new RichText(text: TextSpan(text: "Sunrise: "+temp['Sunrise'],style: TextStyle(color: Colors.brown,fontSize: 30))),
                    new RichText(text: TextSpan(text: "Dhuhr: "+temp['Dhuhr'],style: TextStyle(color: Colors.brown,fontSize: 30))),
                    new RichText(text: TextSpan(text: "Asr"": "+temp['Asr'],style: TextStyle(color: Colors.brown,fontSize: 30))),
                    new RichText(text: TextSpan(text: "Maghrib: "+temp['Maghrib'],style: TextStyle(color: Colors.brown,fontSize: 30))),
                    new RichText(text: TextSpan(text: "Isha: "+temp['Isha'],style: TextStyle(color: Colors.brown,fontSize: 30))),

                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}