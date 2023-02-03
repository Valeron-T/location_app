import 'dart:math';

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
          colorScheme: ColorScheme.dark(), brightness: Brightness.dark),
      home: LogInPage(title: 'LogInPage'),
    );
  }
}

var w = Colors.white;
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
      appBar: AppBar(
        titleTextStyle: TextStyle(color: w, fontSize: 40),
        title: Text("DRONE CONNECTION"),
        centerTitle: true,
        backgroundColor: b,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Welcome',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              width: 200,
              child: TextField(
                controller: pc,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'PASSWORD',
                  hintText: 'Enter Password',
                ),
              ),
            ),
            FloatingActionButton.extended(
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
            FloatingActionButton.extended(
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
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class SettingPage extends StatelessWidget {
  SettingPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(color: w, fontSize: 40),
        title: Text("SETTINGS"),
        centerTitle: true,
        backgroundColor: b,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ToggleSwitch(),
        ],
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
          child: Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                print(isSwitched);
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
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
