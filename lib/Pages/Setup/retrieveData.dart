import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'myData.dart';

class retrieveData extends StatefulWidget {
  @override
  _retrieveDataState createState() => _retrieveDataState();
}

class _retrieveDataState extends State<retrieveData> {
  List<myData> allData = [];

  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();

    ref.child('items').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allData.clear();
      for (var key in keys) {
        myData d = new myData(
            data[key]['MName'],
            data[key]['Fajr'],
            data[key]['Dhur'],
            data[key]['Asr'],
            data[key]['Maghrib'],
            data[key]['Isha']
        );

        allData.add(d);
      }

      setState(() {
        print('Length : $widget(allData.length)');
      });
    }
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return null;
//  }
//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Firebase Data'),
          backgroundColor: Colors.brown,
        ),

        body: new Container(
            child: allData.length == 0
                ? new Text(' Fetching Data from Database')
                : new ListView.builder(
                itemCount: allData.length,
                itemBuilder: (_,index) {
                  return UI(allData[index].MName,allData[index].Fajr,allData[index].Dhur,allData[index].Asr,allData[index].Maghrib,allData[index].Isha,
                  );
                }

            )
        )
    );
  }






  Widget UI(String MName,String Fajr,String Dhur,String Asr,String Maghrib, String Isha) {
    return new Card(
      elevation: 10.0,
      child: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('Masjid Name: $MName',style: Theme.of(context).textTheme.title,),
            new Text('Fajr: $Fajr',style: Theme.of(context).textTheme.title,),
            new Text('Dhur: $Dhur',style: Theme.of(context).textTheme.title,),
            new Text('Asr: $Asr',style: Theme.of(context).textTheme.title,),
            new Text('Maghrib: $Maghrib',style: Theme.of(context).textTheme.title,),
            new Text('Isha: $Isha',style: Theme.of(context).textTheme.title,),



          ],
        ),
      ),
    );
  }

}