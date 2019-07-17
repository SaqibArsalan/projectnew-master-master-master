import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/Compass.dart';
import "package:google_maps_webservice/geocoding.dart";
import 'package:geo_location_finder/geo_location_finder.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:project/Pages/Setup/MainPage.dart';
import 'package:project/Pages/Setup/getTimings.dart';
import 'package:project/Pages/Setup/retrieveData.dart';
import 'package:project/Pages/Setup/signIn.dart';
import 'package:project/Pages/Setup/timings.dart';
import 'package:project/Pages/Setup/welcome.dart';


//
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Home());
  }
}

//  _MyAppState createState() => _MyAppState();


class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => new _HomeState();
}



class _HomeState extends State {


  Completer<GoogleMapController> _controller = Completer();

  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  static const kGoogleApiKey = "AIzaSyC_2vdelF5OBkFaphMp265a44jVwcF_eYI";

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  var result;

  static  LatLng _center =  LatLng(24.773, 67.0762);


  final Set<Marker> _markers = {};

  final Set<Polyline> _poly={};

  static  LatLng _lastMapPosition = _center;


  List<Widget> v=[];


  MapType _currentMapType = MapType.normal;

  static List<LatLng> points=new List<LatLng>();

  List<PlacesSearchResult> places = [];

  List<String> name = [];

  List<String> address = [];

  void _onMapTypeButtonPressed() {

    setState(() {

      _currentMapType = _currentMapType == MapType.normal

          ? MapType.satellite

          : MapType.normal;

    });

  }

  Future<void> _setLocation() async {
    Map<dynamic, dynamic> locationMap;
    String result;
    try {
      locationMap = await GeoLocation.getLocation;

      var status = locationMap["status"];
      if ((status is String && status == "true") ||
          (status is bool) && status) {
        var lat = locationMap["latitude"];
        var lng = locationMap["longitude"];
        if (lat is String) {
          result = "Location: ($lat, $lng)";

          _center=LatLng(double.parse(lat),double.parse(lng));

//          print(double.parse(lat));
        } else {
          // lat and lng are not string, you need to check the data type and use accordingly.
          // it might possible that else will be called in Android as we are getting double from it.
          _center=LatLng(lat, lng);
          result = "Location: ($lat, $lng)";
        }
      } else {
        result = locationMap["message"];
      }

    }
    catch(e){

    }

  }
 void p1(){

 }



  void _onAddMarkerButtonPressed() async {

    _goToTheLocation();

    var location = Location(_center.latitude,_center.longitude);


    result = await _places.searchByText("Masjid",location: location,type: "Masjid");
    setState(() {

      result.results.forEach((f) {

        this.places = result.results;

        LatLng mosqueLocation= LatLng(f.geometry.location.lat, f.geometry.location.lng);
        print(f.name);
        name.add(f.name);
        points.add(mosqueLocation);
        address.add(f.formattedAddress);
        _lastMapPosition=mosqueLocation;
        List x=new List<LatLng>();
        x.add(mosqueLocation);



        print(f.geometry.location.lat.toString() + f.geometry.location.lng.toString());
        _markers.add(Marker(


          // This marker id can be anything that uniquely identifies each marker.

          markerId: MarkerId(_lastMapPosition.toString()),

          position:  _lastMapPosition,

          infoWindow: InfoWindow(

            title: f.name,

            snippet:f.formattedAddress,

          ),

          icon: BitmapDescriptor.defaultMarker,
        ));
      });

    });


  }



  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }
  Future<void> _goToTheLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(_center,17));




  }



  Future _onMapCreated(GoogleMapController controller) async {
    _setLocation();
     _controller.complete(controller);

    //_poly.add(new Polyline(
      //polylineId: PolylineId("abc"),
     // points: [new LatLng(_center.latitude, _center.longitude),new LatLng(24.9303021,67.0424375)],
      //color: Colors.blueAccent,
      //geodesic: true,
    //));




  }

  Widget buildCard(BuildContext context,int index){
    return Card(
      
      elevation: 7.0,
        child: new InkWell(
          splashColor: Colors.blue.withAlpha(50),
          onTap: () {
          print("tapped");
          },
          child : Container(
            padding: EdgeInsets.all(8),
            height:175,
            decoration: BoxDecoration(color: Colors.brown[50]),
            width: 290,
           child: Align(
             alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
               children: <Widget>[
                 ListTile(
                   title: Text(name[index],style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                   subtitle: Text(address[index]),
                   leading: Icon(Icons.indeterminate_check_box,color: Colors.brown),
              ),
                 ButtonTheme.bar(
                   child: Align(
                     alignment: Alignment.bottomRight,
                     child: ButtonBar(
                       mainAxisSize: MainAxisSize.min,
                       children: <Widget>[
                         FlatButton(
                           child: const Text("Directions"),
                           onPressed: (){

                           },
                         ),
                       ],
                     ),
                   ),
                 ),
            ],
          ),
          ),
          ),


        ),

    );
  }

  Widget buildContainer(){
    return Align(
      alignment: Alignment.bottomLeft,
      child:  Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: buildCard,
          itemCount: places.length,
        ),
      ),
    );

  }




  @override
  Widget build(BuildContext context) {

      return new Scaffold(

        appBar: AppBar(

          title: Text('Pro Masjid Finder'),

          backgroundColor: Colors.brown[700],

        ),

        body: Stack(

          children: <Widget>[

            GoogleMap(

              onMapCreated: _onMapCreated,

              initialCameraPosition: CameraPosition(

                target: _center,

                zoom: 10.0,

              ),

              mapType: _currentMapType,

              markers: _markers,

              onCameraMove: _onCameraMove,

              myLocationEnabled:true,


            ),


            buildContainer(),


            Padding(

              padding: const EdgeInsets.all(16.0),

              child: Align(

                alignment: Alignment.topRight,

                child: Column(



                  children: <Widget>[

                    SizedBox(height: 60.0),


                    new FloatingActionButton(

                      heroTag: 'btn1',

                      onPressed: _onMapTypeButtonPressed,

                      materialTapTargetSize: MaterialTapTargetSize.padded,

                      backgroundColor: Colors.brown[700],

                      child: const Icon(Icons.map, size: 36.0),


                    ),

                    SizedBox(height: 16.0),

                    new FloatingActionButton(
                      heroTag: 'btn2',

                      onPressed: _onAddMarkerButtonPressed,

                      materialTapTargetSize: MaterialTapTargetSize.padded,

                      backgroundColor: Colors.brown[700],

                      child: const Icon(Icons.add_location, size: 36.0),

                    ),

                    SizedBox(height: 16.0),

                    FloatingActionButton(
                      child: const Icon(Icons.brightness_3, size:36.0),

                      materialTapTargetSize: MaterialTapTargetSize.padded,


                      backgroundColor: Colors.brown[700],

                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));
                      },
                    ),
                    SizedBox(height: 16.0),

                    new FloatingActionButton(
                      heroTag: 'btne',

                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => qiblaDirection()));
                      },

                      materialTapTargetSize: MaterialTapTargetSize.padded,

                      backgroundColor: Colors.brown[700],

                      child: const Icon(Icons.arrow_upward, size: 36.0),

                    ),


                    SizedBox(height: 16.0),

                    new FloatingActionButton(
                      heroTag: 'btn6',

                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => retrieveData()));
                      },

                      materialTapTargetSize: MaterialTapTargetSize.padded,

                      backgroundColor: Colors.brown[700],

                      child: const Icon(Icons.access_time, size: 36.0),

                    ),

//
//                    FloatingActionButton(
//                      onPressed: (){
//                        Route route = MaterialPageRoute(builder: (context) => Compass());
//                        Navigator.push(context, route);
//                        },
//
//
//
//                      materialTapTargetSize: MaterialTapTargetSize.padded,
//
//                      backgroundColor: Colors.green,
//
//                      child: const Icon(Icons.near_me, size: 36.0),
//
//
//                    ),



                  ],

                ),

              ),

            ),

          ],

        ),

      );



  }

//  void openCompass() async {
//
//
//    Navigator.of(context).pushNamed('/compass');

//  }

}