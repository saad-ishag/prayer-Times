import 'package:flutter/material.dart';
import 'package:navigation_demo_starter/city.dart';
import 'dart:math';
import '../constants.dart';
import '../helper/getTimes.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class Times extends StatefulWidget {
  final times ;
  Times({this.times});
  @override
  State<Times> createState() => _TimesState();
}

class _TimesState extends State<Times> {
  @override
  void initState() {
    updateUI(widget.times);
    super.initState();
  }
  String cityName ;
  String fajr ;
  String dhuhr ;
  String asr ;
  String magrib ;
  String esha ;
  GetTimes getTimes =GetTimes();

  void updateUI(dynamic getTimes){
    setState(() {
      if(getTimes==null){
        fajr='';dhuhr='';asr='';magrib='';esha='';
        return ;
      }
   fajr =  getTimes['results']['datetime'][0]['times']['Fajr'];
   dhuhr = getTimes['results']['datetime'][0]['times']['Dhuhr'];
   asr =  getTimes['results']['datetime'][0]['times']['Asr'];
   magrib =  getTimes['results']['datetime'][0]['times']['Maghrib'];
   esha =  getTimes['results']['datetime'][0]['times']['Isha'];

    });
  }

  @override
  Widget build(BuildContext context) {
   int imageNumber =Random().nextInt(5)+1;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/$imageNumber.jpg'),
            fit:BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.9), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TypeAheadField<City>(
                    hideOnEmpty: true,
                    hideOnError: true,
                    getImmediateSuggestions: true,
                    suggestionsBoxDecoration: SuggestionsBoxDecoration(
                      shadowColor: Colors.white54,
                      color: Colors.white54,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20),)
                    ),
                    debounceDuration        : Duration(milliseconds: 500),
                    textFieldConfiguration  : TextFieldConfiguration(
                      style: TextStyle(fontSize: 18,color: Colors.white),
                      decoration: kTextFieldStyle,
                    ),
                    noItemsFoundBuilder     : (context){
                        return Container(child: Center(child: Text('No city found')),height: 60,);
                    },
                    suggestionsCallback:getTimes.getSuggestions,
                    itemBuilder: (context,City suggestion){
                      return ListTile(title: Text(suggestion.name));
                    },

                    onSuggestionSelected:(City suggestion)async{
                      cityName = suggestion.name.toString();
                      var pTimes = await getTimes.cityPrayerTimes(cityName);
                      updateUI(pTimes);
                    },

                  )
                ),
              ),
              Expanded(
              flex: 7,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fajr     $fajr',style: kTextStyle),
                  Text('Dhuhr    $dhuhr',style: kTextStyle),
                  Text('Asr      $asr',style: kTextStyle),
                  Text('Maghrib  $magrib',style: kTextStyle),
                  Text('Isha     $esha',style: kTextStyle),
                ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
