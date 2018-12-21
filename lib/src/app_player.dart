import 'package:flutter/material.dart';

import 'widgets/video_player.dart';

class App extends StatefulWidget {
  final String apiBaseUrl = "http://ott-api.iskon.hr/proxy/";
  final String ontvUrl = "ontv-now/";

  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       image: AssetImage("assets/images/bg_image.png"),
          //       fit: BoxFit.fill),
          // ),
          child: Card(
            child: VideoPlayer(),
          )
        ),
        backgroundColor: Color.fromRGBO(32, 36, 40, 1),
        appBar: AppBar(
          title: Text('Player'),
        ),
      ),
      // theme: ThemeData(
      //   fontFamily: 'Tele-Grotesk',
      // ),
    );
  }

}
