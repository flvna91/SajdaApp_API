import 'package:flutter/material.dart';
//import 'package:flutter_test_drive/SajdaSettings.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_test_drive/data.dart';
import 'dart:ui';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:compass_icon/compass_icon.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Data list;

  final String url =
      'https://api.aladhan.com/v1/timingsByCity?city=Jakarta&country=Indonesia&method=8';

  Future getPTData() async {
    http.Response res = await http.get(Uri.encodeFull(url), headers: {
      "Accept":
          "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=o.8"
    });
    final data = jsonDecode(res.body);

    list = Data.fromJson(data);

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: getPTData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return MaterialApp(
                home: Scaffold(
              body: Stack(
                children: <Widget>[
                  //background
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/bg.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Color.fromARGB(0, 0, 0, 0), BlendMode.darken),
                      ),
                    ),
                  ),

                  //Waktu saat ini, hijriyah
                  Container(
                    width: 145,
                    height: 65,
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 310),
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Senin",
                              style: TextStyle(
                                  color: Color.fromARGB(183, 255, 255, 255),
                                  fontSize: 14,
                                  height: 2.2),
                            ),
                            Text(
                              "30 Rabiul Awal, 1444",
                              style: TextStyle(
                                  color: Color.fromARGB(183, 255, 255, 255),
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  //Lokasi
                  Container(
                    width: 70,
                    height: 70,
                    margin: EdgeInsets.fromLTRB(350, 30, 0, 310),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Jakarta",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  height: 2.2,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Pekojan",
                              style: TextStyle(
                                  color: Color.fromARGB(183, 255, 255, 255),
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  //Waktu Saat Ini
                  Container(
                    margin: EdgeInsets.fromLTRB(355, 85, 0, 310),
                    //padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    //height: 30,
                    //width: 45,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                      //margin: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                        color: Color.fromARGB(93, 0, 0, 0),
                      ),
                      child: Text(
                        '03:00',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),

                  //Container Waktu Sholat
                  Container(
                    margin: EdgeInsets.fromLTRB(90, 230, 90, 0),
                    //padding: EdgeInsets.only(left: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 310,
                    width: 230,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: Color.fromARGB(248, 0, 0, 0),
                      ),
                    ),
                  ),

                  //Subuh
                  Container(
                    margin: EdgeInsets.fromLTRB(113, 250, 0, 0),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text("Subuh",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          Padding(padding: EdgeInsets.fromLTRB(90, 0, 0, 0)),
                          Text(snapshot.data.data.timings.fajr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19)),
                        ],
                      ),
                    ),
                  ),

                  //Terbit
                  Container(
                    margin: EdgeInsets.fromLTRB(113, 290, 0, 0),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text("Terbit",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          Padding(padding: EdgeInsets.fromLTRB(95, 0, 0, 0)),
                          Text(snapshot.data.data.timings.sunrise,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19)),
                        ],
                      ),
                    ),
                  ),

                  //Dzuhur
                  Container(
                    margin: EdgeInsets.fromLTRB(113, 332, 0, 0),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text("Dzuhur",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          Padding(padding: EdgeInsets.fromLTRB(85, 0, 0, 0)),
                          Text(snapshot.data.data.timings.dhuhr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19)),
                        ],
                      ),
                    ),
                  ),

                  //Ashar
                  Container(
                    margin: EdgeInsets.fromLTRB(113, 373, 0, 0),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text("Ashar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          Padding(padding: EdgeInsets.fromLTRB(92, 0, 0, 0)),
                          Text(snapshot.data.data.timings.asr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19)),
                        ],
                      ),
                    ),
                  ),

                  //Magrib
                  Container(
                    margin: EdgeInsets.fromLTRB(113, 413, 0, 0),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text("Magrib",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          Padding(padding: EdgeInsets.fromLTRB(85, 0, 0, 0)),
                          Text(snapshot.data.data.timings.maghrib,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19)),
                        ],
                      ),
                    ),
                  ),

                  //Isya
                  Container(
                    margin: EdgeInsets.fromLTRB(113, 455, 0, 0),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text("Isya",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          Padding(padding: EdgeInsets.fromLTRB(105, 0, 0, 0)),
                          Text(snapshot.data.data.timings.isha,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19)),
                        ],
                      ),
                    ),
                  ),

                  //Jam Sholat Saat ini
                  Container(
                    margin: EdgeInsets.fromLTRB(90, 500, 90, 0),
                    //padding: EdgeInsets.only(left: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 40,
                    width: 230,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10)),
                        color: Color.fromARGB(230, 76, 175, 79),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                          Text("Subuh",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          Padding(padding: EdgeInsets.fromLTRB(75, 0, 0, 0)),
                          Text("01:24:42",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18))
                        ],
                      ),
                    ),
                  ),

                  //Button Bawah
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 633, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                        Icon(
                          CupertinoIcons.compass,
                          color: Colors.white,
                          size: 30,
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(140, 0, 00, 0)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                              size: 30,
                            )),
                        Padding(padding: EdgeInsets.fromLTRB(132, 0, 0, 0)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark_border,
                              color: Colors.white,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ));
          },
        ),
      ),
    );
  }
}
