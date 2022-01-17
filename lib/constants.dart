import 'package:flutter/material.dart';
const  kTextStyle =TextStyle(fontSize: 30,color: Colors.pink,fontWeight:FontWeight.w400,fontFamily:'SpaceMono');
const kTextFieldStyle =InputDecoration(

    filled: true,
    fillColor: Colors.black38,
    hintText: 'Search for other city',
    hintStyle:TextStyle(
        color: Colors.grey
    ),
    suffixIcon: Icon(Icons.search),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20),),
      borderSide: BorderSide.none,
    )
);