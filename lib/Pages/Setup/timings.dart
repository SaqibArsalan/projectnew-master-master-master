import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:flutter_app_firebase/Pages/Setup/home.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class namazTimings extends StatefulWidget {
  @override
  _namazTimingsState createState() => _namazTimingsState();
}

class _namazTimingsState extends State<namazTimings> {
  List<Item> items = List();
  Item item;
  DatabaseReference itemRef;

  final formats = {
    InputType.time: DateFormat("HH:mm")

  };

  InputType inputType = InputType.time;
  bool editable = true;
  DateTime _dateTime;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    item = Item("","","","","");
    final FirebaseDatabase database = FirebaseDatabase.instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('items');
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);

  }

  _onEntryAdded(Event event) {
    setState(() {
      items.add(Item.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = items.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      items[items.indexOf(old)] = Item.fromSnapshot(event.snapshot);
    });
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      form.reset();
      itemRef.child("Saqib").set(item.toJson());
    }
  }

//
//  _savedData() {
//    DateTime Fajr;
//    DateTime Dhur;
//    DateTime Asr;
//    DateTime Maghrib;
//    DateTime Isha;
//
//    itemRef.push().set({
//      'Fajr': Fajr,
////      'Dhur': Dhur,
////      'Full name': FName,
////      'Phone num': Phone,
//      //  'Date:' : date,
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timings'),
        centerTitle: true,
      ),
      resizeToAvoidBottomPadding: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Flexible(
            flex: 0,
            child: Center(
              child: Form(
                key: formKey,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
//                    ListTile(
//                      leading: Text("Fajr"),
//                      title: TextFormField(
//                        initialValue: "",
//                        onSaved: (val) => item.Fajr = val,
//                        validator: (val) => val == "" ? val : null,
//                      ),
//                    ),



                    DateTimePickerFormField(

                      inputType: InputType.both,
                      format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
                      editable: editable,
                      onSaved: (val) => item.Fajr = val.toIso8601String() ,
                      decoration: InputDecoration(
                        labelText: 'Fajr',
                        hasFloatingPlaceholder: false,


                      ),
                    ),


                    DateTimePickerFormField(

                      inputType: InputType.both,
                      format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
                      editable: editable,
                      onSaved: (val) => item.Dhur = val.toIso8601String() ,
                      decoration: InputDecoration(
                        labelText: 'Dhur',
                        hasFloatingPlaceholder: false,


                      ),
                    ),
//
                    DateTimePickerFormField(

                      inputType: InputType.both,
                      format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
                      editable: editable,
                      onSaved: (val) => item.Asr = val.toIso8601String() ,
                      decoration: InputDecoration(
                        labelText: 'Asr',
                        hasFloatingPlaceholder: false,


                      ),
                    ),
//
                    DateTimePickerFormField(

                      inputType: InputType.both,
                      format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
                      editable: editable,
                      onSaved: (val) => item.Maghrib = val.toIso8601String() ,
                      decoration: InputDecoration(
                        labelText: 'Maghrib',
                        hasFloatingPlaceholder: false,


                      ),
                    ),
//
                    DateTimePickerFormField(

                      inputType: InputType.both,
                      format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
                      editable: editable,
                      onSaved: (val) => item.Isha = val.toString(),
                      decoration: InputDecoration(
                        labelText: 'Isha',
                        hasFloatingPlaceholder: false,


                      ),
                    ),
//
//
//                    ListTile(
//                      leading: Text("Dhur"),
//                      title: TextFormField(
//                        initialValue: '',
//                        onSaved: (val) => item.Dhur = val,
//                        validator: (val) => val == "" ? val : null,
//                      ),
//                    ),
//                    ListTile(
//                      leading: Text("Asr"),
//                      title: TextFormField(
//                        initialValue: "",
//                        onSaved: (val) => item.Asr = val,
//                        validator: (val) => val == "" ? val : null,
//                      ),
//                    ),
//                    ListTile(
//                      leading: Text("Maghrib"),
//                      title: TextFormField(
//                        initialValue: "",
//                        onSaved: (val) => item.Maghrib = val,
//                        validator: (val) => val == "" ? val : null,
//                      ),
//                    ),
//                    ListTile(
//                      leading: Text("Isha"),
//                      title: TextFormField(
//                        initialValue: "",
//                        onSaved: (val) => item.Isha = val,
//                        validator: (val) => val == "" ? val : null,
//                      ),
//                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        handleSubmit();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
//          Flexible(
//            child: FirebaseAnimatedList(
//              query: itemRef,
//              itemBuilder: (BuildContext context, DataSnapshot snapshot,
//                  Animation<double> animation, int index) {
//                return new ListTile(
//                  leading: Icon(Icons.check_box),
//                  title: Text(items[index].title),
//                  subtitle: Text(items[index].body),
//
//
//                );
//              },
//            ),
//          ),
        ],
      ),
    );
  }
}

class Item {
  String key;
  String Fajr;
  String Dhur;
  String Asr;
  String Maghrib;
  String Isha;
  Item(this.Fajr, this.Dhur,this.Asr,this.Maghrib,this.Isha);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        Fajr= snapshot.value['Fajr'],
        Dhur = snapshot.value["Dhur"],
        Asr = snapshot.value["Asr"],
        Maghrib = snapshot.value["Maghrib"],
        Isha = snapshot.value["Isha"];

  toJson() {
    return {
      "Fajr" : Fajr,
      "Dhur": Dhur,
      "Asr": Asr,
      "Maghrib" : Maghrib,
      "Isha": Isha
    };
  }


}

