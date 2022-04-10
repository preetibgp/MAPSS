import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var locationMessage = "";
  String latitude = "";
  String longitude = "";
  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;
    latitude = "$lat";
    longitude = "$long";

    setState(() {
      locationMessage = "Latitude=$lat and Longitude=$long";
    });
  }

  void googleMap() async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else
      throw ("could not open google maps");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Get User Location",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(locationMessage),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                color: Colors.white,
                onPressed: () {
                  getCurrentLocation();
                },
                child: Text(
                  "Get User Location",
                  // style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                color: Colors.white,
                onPressed: () {
                  googleMap();
                },
                child: Text(
                  "Open google Map",
                  //  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
