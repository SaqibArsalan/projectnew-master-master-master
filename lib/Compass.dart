import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;


//void main() => runApp(MyApp());



class qiblaDirection extends StatefulWidget {

  @override

  _qiblaDirectionState createState() => _qiblaDirectionState();

}



class _qiblaDirectionState extends State<qiblaDirection> {

  double _direction;

  @override
  void initState() {
    super.initState();

    FlutterCompass.events.listen((double direction) {
      setState(() {
        _direction = direction;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Flutter Compass'),
        ),
        body: new Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: new Transform.rotate(
            angle: ((_direction+(92)?? 0) * (math.pi / 180) * -1),
            child: new Image.asset('assets/NorthStar.jpg'),
          ),
        ),
      ),
    );
  }
}