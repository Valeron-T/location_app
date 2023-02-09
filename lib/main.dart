// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:drone_app/config.dart';
import 'package:drone_app/theme.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// import 'dart:js';
import 'dart:math';
// import 'dart:ui';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('easyTheme');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Adds a listener which updates everytime source was updated
    currentTheme.addListener(() {
      print("State Changed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Drone Information",
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: currentTheme.currentTheme(),
      home: InfoPage(title: 'LogInPage'),
      // home: SettingPage(title: 'settings'),
    );
  }
}

var white = Colors.white;
var w = Colors.grey[300];
var b = Colors.black;
var h = 'METERS';

class MyTheme with ChangeNotifier {
  static bool _isDark = false;
  final myBox = Hive.box('easyTheme');

  MyTheme() {
    if (myBox.containsKey('CurrentTheme')) {
      _isDark = myBox.get('CurrentTheme');
    } else {
      myBox.put('CurrentTheme', _isDark);
    }
  }

  switchTheme(bool curValue) {
    notifyListeners();
    _isDark = curValue;
    print(_isDark);
    myBox.put('CurrentTheme', _isDark);
    print(myBox.get('CurrentTheme'));
  }

  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }
}

// Login page
class LogInPage extends StatelessWidget {
  LogInPage({Key? key, required this.title}) : super(key: key);
  final String title;

  static const p = 'user';
  final pc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   // titleTextStyle: TextStyle(color: b),
      //   // title: Text("DRONE CONNECTION"),
      //   leading: Icon(Icons.android_rounded),
      //   centerTitle: true,
      //   shadowColor: Colors.transparent,
      //   backgroundColor: Colors.grey[300],
      // ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: height,
            padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/blur-bg.jpg"),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Drone',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: white),
                  ),
                  Text(
                    'Tracking',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 40,
                        color: white),
                  ),
                  Text(
                    'Made Easy',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: white),
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
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                          fillColor: white,
                          labelStyle:
                              TextStyle(color: white, letterSpacing: 1.5),
                          hintStyle: TextStyle(color: white),
                          hoverColor: white,
                          focusColor: Colors.amber[300],
                          prefixIcon: Icon(
                            Icons.person_rounded,
                            color: white,
                          ),
                          labelText: 'Username',
                          hintText: 'Enter Username',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: SizedBox(
                      child: TextField(
                        controller: pc,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                          fillColor: white,
                          labelStyle:
                              TextStyle(color: white, letterSpacing: 1.5),
                          hintStyle: TextStyle(color: white),
                          hoverColor: white,
                          focusColor: Colors.amber[300],
                          prefixIcon: Icon(
                            Icons.lock,
                            color: white,
                          ),
                          labelText: 'Password',
                          hintText: 'Enter Password',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  FloatingActionButton(
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
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.5, color: white),
                        borderRadius: BorderRadius.circular(100)),
                    foregroundColor: Colors.white,
                    child: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                  SizedBox(
                    height: height * 0.2,
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "First Time ?",
                              style: TextStyle(color: white),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "Sign Up Now !",
                              style: TextStyle(color: white),
                              textAlign: TextAlign.start,
                            )
                          ],
                        ),
                        FloatingActionButton(
                          heroTag: "settings",
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SettingPage(title: 'SettingPage');
                            }));
                          },
                          shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1.5, color: white),
                              borderRadius: BorderRadius.circular(100)),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          foregroundColor: white,
                          child: Icon(Icons.settings_rounded),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// Settings page
class SettingPage extends StatefulWidget {
  SettingPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isDarkTheme = Hive.box('easyTheme').get('CurrentTheme');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded,
              color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
        shadowColor: Colors.transparent,
        title: Text("Settings"),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        alignment: Alignment.center,
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.background),
        child: Column(
          children: [
            // User instructions
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
                      color: Theme.of(context).colorScheme.primary),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.brush_rounded,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Personalise your experience",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
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
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("Dark Theme"),
                        ),
                        Center(
                          child: CupertinoSwitch(
                            value: isDarkTheme,
                            onChanged: (value) {
                              // Value is true
                              isDarkTheme = value;
                              print(isDarkTheme);
                              currentTheme.switchTheme(value);
                            },
                            trackColor: Colors.red,
                            activeColor: Colors.green,
                          ),
                        ),
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
                      color: Theme.of(context).colorScheme.primary),
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
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
                            backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.secondary,
                            )),
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
    return Stack(
      children: [
        // Scaffold(
        //   backgroundColor: w,
        //   appBar: AppBar(
        //     titleTextStyle: TextStyle(color: w),
        //     title: Text("DRONE INFORMATION"),
        //     centerTitle: true,
        //     backgroundColor: b,
        //   ),
        //   body: Center(
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: <Widget>[
        //         Column(
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: <Widget>[
        //             Container(
        //                 width: MediaQuery.of(context).size.width - 4,
        //                 height: MediaQuery.of(context).size.height - 56 - 60,
        //                 alignment: Alignment.center,
        //                 child: OpenStreetMapSearchAndPick(
        //                     center: LatLong(18.9426, 72.8311),
        //                     buttonColor: Colors.blueAccent,
        //                     buttonText: 'Drone Location',
        //                     onPicked: (pickedData) {
        //                       showDialog(
        //                           context: context,
        //                           builder: (ctx) => AlertDialog(
        //                                   title: const Text("Drone Location:"),
        //                                   content: Text(pickedData.address),
        //                                   actions: <Widget>[
        //                                     TextButton(
        //                                       onPressed: () {
        //                                         Navigator.of(ctx).pop();
        //                                       },
        //                                       child: Container(
        //                                         color: Colors.black,
        //                                         padding:
        //                                             const EdgeInsets.all(14),
        //                                         child: const Text("okay",
        //                                             style: TextStyle(
        //                                                 color: Color.fromARGB(
        //                                                     255,
        //                                                     240,
        //                                                     240,
        //                                                     240))),
        //                                       ),
        //                                     )
        //                                   ]));
        //                     })),
        //           ],
        //         ),
        //         // Column(
        //         //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         //   children: <Widget>[
        //         //     Container(
        //         //       width: MediaQuery.of(context).size.width / 2 - 4,
        //         //       height: MediaQuery.of(context).size.height / 4 - 14 - 4,
        //         //       color: bc(bat),
        //         //       alignment: Alignment.center,
        //         //       child: Text(
        //         //         "BATTERY: $bat %",
        //         //         style: TextStyle(fontSize: 20, color: Colors.black),
        //         //       ),
        //         //     ),
        //         //     Container(
        //         //       width: MediaQuery.of(context).size.width / 2 - 4,
        //         //       height: MediaQuery.of(context).size.height / 4 - 14 - 4,
        //         //       alignment: Alignment.center,
        //         //       color: Colors.cyanAccent,
        //         //       child: Text(
        //         //         "ALTITUDE: $al $h",
        //         //         style: TextStyle(fontSize: 20, color: Colors.black),
        //         //       ),
        //         //     ),
        //         //     Container(
        //         //       width: MediaQuery.of(context).size.width / 2 - 4,
        //         //       height: MediaQuery.of(context).size.height / 4 - 14 - 4,
        //         //       alignment: Alignment.center,
        //         //       color: Colors.brown,
        //         //       child: Text(
        //         //         "FACING: $face",
        //         //         style: TextStyle(fontSize: 20, color: Colors.white),
        //         //       ),
        //         //     ),
        //         //     Container(
        //         //       width: MediaQuery.of(context).size.width / 2 - 4,
        //         //       height: MediaQuery.of(context).size.height / 4 - 14 - 4,
        //         //       color: Colors.redAccent,
        //         //       alignment: Alignment.center,
        //         //       child: FloatingActionButton.extended(
        //         //         onPressed: () {
        //         //           Navigator.pushReplacement(context,
        //         //               MaterialPageRoute(builder: (context) {
        //         //             return LogInPage(title: 'LogInPage');
        //         //           }));
        //         //         },
        //         //         label: Text('Disconnect'),
        //         //         icon: Icon(Icons.cloud_off),
        //         //         backgroundColor: Colors.white,
        //         //         foregroundColor: Colors.redAccent,
        //         //       ),
        //         //     ),
        //         //   ],
        //         // ),
        //       ],
        //     ),
        //   ),
        // ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width - 20,
                    child: Text("Hello"),
                    decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(15), color: w),
                  )
                ],
              ),
              Row(
                children: [
                  Stack(children: [
                    Container(
                      transform: Matrix4.translationValues(0, 18.0, 0.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(69, 30),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            transform: Matrix4.translationValues(-25, 5.0, 0.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.background,
                            ),
                            height: MediaQuery.of(context).size.height / 5.5,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: SfRadialGauge(
                              backgroundColor: Colors.transparent,
                              // backgroundColor: Theme.of(context).colorScheme.background,
                              enableLoadingAnimation: true,
                              animationDuration: 3000,
                              axes: [
                                RadialAxis(
                                  isInversed: true,
                                  startAngle: 225,
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      angle: 120,
                                      positionFactor: 0.5,
                                      widget: Text(
                                        '69',
                                        style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontFamily: 'DIGI',
                                          fontSize: 35,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                  pointers: <GaugePointer>[
                                    NeedlePointer(
                                        value: 69,
                                        needleStartWidth: 0.5,
                                        needleEndWidth: 3,
                                        knobStyle: KnobStyle(
                                            knobRadius: 6,
                                            sizeUnit:
                                                GaugeSizeUnit.logicalPixel,
                                            color: Colors.red))
                                  ],
                                  majorTickStyle: MajorTickStyle(
                                    length: 0.1,
                                    lengthUnit: GaugeSizeUnit.factor,
                                    thickness: 1,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  axisLineStyle: AxisLineStyle(
                                    color: Colors.white,
                                    cornerStyle: CornerStyle.bothCurve,
                                    gradient: SweepGradient(
                                        colors: <Color>[yellow, green, red],
                                        stops: <double>[0.0, 0.5, 0.90]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            transform: Matrix4.translationValues(
                                MediaQuery.of(context).size.width * 0.07,
                                5.0,
                                0.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.background,
                            ),
                            height: MediaQuery.of(context).size.height / 5.5,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: SfRadialGauge(
                              backgroundColor: Colors.transparent,
                              // backgroundColor: Theme.of(context).colorScheme.background,
                              enableLoadingAnimation: true,
                              animationDuration: 3000,
                              axes: [
                                RadialAxis(
                                  startAngle: 130,
                                  endAngle: 300,
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      angle: 60,
                                      positionFactor: 0.5,
                                      widget: Text(
                                        '30',
                                        style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontFamily: 'DIGI',
                                          fontSize: 35,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                  pointers: <GaugePointer>[
                                    NeedlePointer(
                                        value: 30,
                                        needleStartWidth: 0.5,
                                        needleEndWidth: 3,
                                        knobStyle: KnobStyle(
                                            knobRadius: 6,
                                            sizeUnit:
                                                GaugeSizeUnit.logicalPixel,
                                            color: Colors.red))
                                  ],
                                  majorTickStyle: MajorTickStyle(
                                    length: 0.1,
                                    lengthUnit: GaugeSizeUnit.factor,
                                    thickness: 1,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  axisLineStyle: AxisLineStyle(
                                    color: Colors.white,
                                    cornerStyle: CornerStyle.bothCurve,
                                    gradient: SweepGradient(
                                        colors: <Color>[yellow, green, red],
                                        stops: <double>[0.0, 0.5, 0.90]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
