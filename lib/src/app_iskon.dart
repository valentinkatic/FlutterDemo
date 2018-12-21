import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';

import 'models/channel_iskon.dart';
import 'models/ontv_response_iskon.dart';
import 'widgets/channel_list_iskon.dart';

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
          title: Text('ISKON'),
        ),
      ),
      // theme: ThemeData(
      //   fontFamily: 'Tele-Grotesk',
      // ),
    );
  }

  Future<List<Channel>> fetchOnTv() async {
    var response = await get('${widget.apiBaseUrl}${widget.ontvUrl}');
    OnTvResponse onTvResponse =
        OnTvResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    List<Channel> list = [];
    onTvResponse.list.forEach((k,v) => list.add(Channel.fromJson(v)));
    return list;
  }
}
