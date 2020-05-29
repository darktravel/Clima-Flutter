import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';
class LocationScreen extends StatefulWidget {
  LocationScreen({this.Locationweather});
  final Locationweather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel we=WeatherModel();
  int temp;
  String Icon1;
  String cityname;
  String mess;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updareUI(widget.Locationweather);
  }
  void updareUI(dynamic decode){
    setState(() {
      if(decode==null){
        temp=0;
        Icon1="ERROR";
        mess="SERVER DOWN";
        cityname="";
      }
      double location=decode['main']['temp'].toDouble();
      temp=location.toInt();
      var condition=decode['weather'][0]['id'];
      Icon1=we.getWeatherIcon(condition);
      mess=we.getMessage(temp);
      cityname=decode['name'];

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherdata=await we.getLocationweather();
                      updareUI(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 20.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      var typedname=await Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return CityScreen();
                        },
                      ),);
                      if(typedname!=null){
                        var wer=await WeatherModel().getCityweather(typedname);
                        updareUI(wer);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temp.toString(),
                      style: kTempTextStyle,
                    ),
                    Text(
                      Icon1,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Text(
                  '$mess in $cityname',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//double location=decode['main']['temp'];
//int condition=decode['weather'][0]['id'];
//String cityname=decode['name'];