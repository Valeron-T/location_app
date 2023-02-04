// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Drone Information",
      theme: ThemeData(
        colorScheme:
            ColorScheme.light(background: Color.fromARGB(255, 110, 110, 110)),
        brightness: Brightness.light,
        fontFamily: 'Poppins',
      ),
      home: LogInPage(title: 'LogInPage'),
    );
  }
}

var white = Colors.white;
var w = Colors.grey[300];
var b = Colors.black;
var h = 'METERS';

class LogInPage extends StatelessWidget {
  LogInPage({Key? key, required this.title}) : super(key: key);
  final String title;

  static const p = 'user';
  final pc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // titleTextStyle: TextStyle(color: b),
      //   // title: Text("DRONE CONNECTION"),
      //   leading: Icon(Icons.android_rounded),
      //   centerTitle: true,
      //   shadowColor: Colors.transparent,
      //   backgroundColor: Colors.grey[300],
      // ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/blur-bg.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Drone',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 40, color: white),
              ),
              Text(
                'Tracking',
                style: TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 40, color: white),
              ),
              Text(
                'Made Simple',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 40, color: white),
              ),
              SizedBox(height: 40),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: SizedBox(
                  child: TextField(
                    controller: pc,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      // border: OutlineInputBorder(),
                      fillColor: white,
                      focusColor: Colors.amber[300],
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'PASSWORD',
                      hintText: 'Enter Password',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              FloatingActionButton.extended(
                heroTag: "info",
                onPressed: () {
                  if (pc.text == p) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return InfoPage(title: 'InfoPage');
                    }));
                  } else {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                                title: const Text("Alert"),
                                content: const Text("Wrong Password"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Container(
                                      color: Colors.black,
                                      padding: const EdgeInsets.all(14),
                                      child: const Text("okay",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 240, 240, 240))),
                                    ),
                                  )
                                ]));
                  }
                },
                label: Text('Connect'),
                icon: Icon(Icons.cloud_sync),
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
              SizedBox(height: 10),
              FloatingActionButton.extended(
                heroTag: "settings",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SettingPage(title: 'SettingPage');
                  }));
                },
                label: Text('Settings'),
                icon: Icon(Icons.settings),
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.black,
              )
            ],
          ),
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// Settings page
class SettingPage extends StatelessWidget {
  SettingPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleTextStyle: TextStyle(color: b, fontSize: 40),
        shadowColor: Colors.transparent,
        title: Text("Settings"),
        backgroundColor: Colors.grey[200],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.grey[200]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1.5,
                            blurRadius: 4,
                            color: Color.fromARGB(31, 211, 211, 211))
                      ],
                      color: Colors.grey[50]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Icon(Icons.brush_rounded),
                              SizedBox(height: 10),
                              Text("Personalise your experience"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Row 1 on settings
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1.5,
                            blurRadius: 4,
                            color: Color.fromARGB(31, 211, 211, 211))
                      ],
                      color: Colors.grey[50]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("Dark Theme"),
                        ),
                        ToggleSwitch(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Row 2
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1.5,
                            blurRadius: 4,
                            color: Color.fromARGB(31, 211, 211, 211))
                      ],
                      color: Colors.grey[50]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("Distance Units"),
                        ),
                        ToggleSwitch(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Row 3
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1.5,
                            blurRadius: 4,
                            color: Color.fromARGB(31, 211, 211, 211))
                      ],
                      color: Colors.grey[50]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("Something else"),
                        ),
                        ToggleSwitch(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1.5,
                            blurRadius: 4,
                            color: Color.fromARGB(31, 211, 211, 211))
                      ]),
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("DONE"),
                        )),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class ToggleSwitch extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ToggleSwitch> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoSwitch(
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
            print(isSwitched);
          });
        },
        trackColor: Colors.red,
        activeColor: Colors.green,
      ),
    );
  }
}

Color bc(int b) {
  if (b >= 75) {
    return (Colors.greenAccent);
  } else if (b >= 50) {
    return (Colors.yellowAccent);
  } else if (b >= 25) {
    return (Colors.orangeAccent);
  } else {
    return (Colors.redAccent);
  }
}

class InfoPage extends StatelessWidget {
  InfoPage({Key? key, required this.title}) : super(key: key);
  final String title;

  static final al = Random().nextInt(100);
  static const l = [
    'NORTH',
    'EAST',
    'WEST',
    'SOUTH',
    'NORTH-EAST',
    'NORTH-WEST',
    'SOUTH-EAST',
    'SOUTH-WEST'
  ];
  static final i = Random().nextInt(l.length);
  static final face = l[i];
  static final bat = Random().nextInt(100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: w,
      appBar: AppBar(
        titleTextStyle: TextStyle(color: w, fontSize: 40),
        title: Text("DRONE INFORMATION"),
        centerTitle: true,
        backgroundColor: b,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                /*Container(
                  color: Colors.grey,
                  width: MediaQuery.of(context).size.width/2-4,
              height: MediaQuery.of(context).size.height-56-4,
              alignment: Alignment.center,
                  
                child: FloatingActionButton.extended(
                onPressed: () async {
                    String url = "https://www.google.com/maps/search/?api=1&query=lat,long";
                    var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                    if(urllaunchable){
                        await launch(url); //launch is from url_launcher package to launch URL
                    }else{
                       print("URL can't be launched.");
                    }
                  },
              label: Text('Location'),
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              foregroundColor: Colors.redAccent,
              icon: Icon(Icons.location_pin),
              ),
            ),*/
                Container(
                    width: MediaQuery.of(context).size.width / 2 - 4,
                    height: MediaQuery.of(context).size.height - 56 - 10,
                    alignment: Alignment.center,
                    child: OpenStreetMapSearchAndPick(
                        center: LatLong(18.9426, 72.8311),
                        buttonColor: Colors.blueAccent,
                        buttonText: 'Drone Location',
                        onPicked: (pickedData) {
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                      title: const Text("Drone Location:"),
                                      content: Text(pickedData.address),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Container(
                                            color: Colors.black,
                                            padding: const EdgeInsets.all(14),
                                            child: const Text("okay",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 240, 240, 240))),
                                          ),
                                        )
                                      ]));
                        })),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 4,
                  height: MediaQuery.of(context).size.height / 4 - 14 - 4,
                  color: bc(bat),
                  alignment: Alignment.center,
                  child: Text(
                    "BATTERY: $bat %",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),

                /*FloatingActionButton.extended(
              onPressed: () async {
                    String url = "https://www.fluttercampus.com";
                    var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                    if(urllaunchable){
                        await launch(url); //launch is from url_launcher package to launch URL
                    }else{
                       print("URL can't be launched.");
                    }
                  },
              label: Text('Altitude'),
              backgroundColor: Colors.tealAccent,
              foregroundColor: Colors.black,
            ),*/
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 4,
                  height: MediaQuery.of(context).size.height / 4 - 14 - 4,
                  alignment: Alignment.center,
                  color: Colors.cyanAccent,
                  child: Text(
                    "ALTITUDE: $al $h",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 4,
                  height: MediaQuery.of(context).size.height / 4 - 14 - 4,
                  alignment: Alignment.center,
                  color: Colors.brown,
                  child: Text(
                    "FACING: $face",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 4,
                  height: MediaQuery.of(context).size.height / 4 - 14 - 4,
                  color: Colors.redAccent,
                  alignment: Alignment.center,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return LogInPage(title: 'LogInPage');
                      }));
                    },
                    label: Text('Disconnect'),
                    icon: Icon(Icons.cloud_off),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
