import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';

import 'models/channel.dart';
import 'models/ontv_response.dart';
import 'widgets/channel_list.dart';

class App extends StatefulWidget {
  final String apiBaseUrl = "http://intra.bulb.hr:8082/OTT4Proxy/proxy/";
  final String ontvUrl = "epg/ontv";

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
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg_image.png"),
                fit: BoxFit.fill),
          ),
          child: FutureBuilder<List<Channel>>(
            future: fetchOnTv(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ChannelList(snapshot.data);
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        backgroundColor: Color.fromRGBO(32, 36, 40, 1),
        appBar: AppBar(
          title: Text('MAXTV TO GO'),
        ),
      ),
      theme: ThemeData(
        fontFamily: 'Tele-Grotesk',
      ),
    );
  }

  Future<List<Channel>> fetchOnTv() async {
    var response = await get('${widget.apiBaseUrl}${widget.ontvUrl}');
    OnTvResponse onTvResponse =
        OnTvResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    // debugPrint(response.body);
    return onTvResponse.data;
  }
}
