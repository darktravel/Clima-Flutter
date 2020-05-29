import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/weather.dart';
import 'dart:convert';
import '../services/location.dart';
import '../services/location.dart';
import 'package:http/http.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {

    var decode=await WeatherModel().getLocationweather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        Locationweather: decode,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SpinKitRotatingCircle(
            color: Colors.white,
            size: 100.0,
          ),
        )
    )
    ;
  }
}
