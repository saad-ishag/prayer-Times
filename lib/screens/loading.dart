import 'package:flutter/material.dart';
import '../helper/getTimes.dart';
import '../helper/location.dart';
import 'prayerTimes_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }
  void getLocationData()async{

    Location location = Location();
    await location.getCurrentLocation();

    var getTimes = await GetTimes().locationPrayerTimes();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Times(times:getTimes ,)));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitFadingFour(
          color: Colors.teal[900],
          size: 100,
        ),
      ),
    );
  }
}
