import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VideoPlayerState();
  }
}

class _VideoPlayerState extends State<VideoPlayer> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    debugPrint('Video Player State init');
    _controller = new VideoPlayerController.network(
      'http://195.29.70.31/PLTV/88888888/224/3221226027/index.m3u8?rrsip=195.29.70.31&zoneoffset=0&servicetype=1&icpid=&accounttype=1&limitflux=-1&limitdur=-1&accountinfo=%7E%7EV2.0%7ElKAuX34KEtpbRR3TJn8SLg%7ESNxFrgA2euoIv3xMzPS4qTxKZVSDkuIBm6yhToTPcHGMaZM1I4y1EtVV4NTLURvy7tW2jfLvf6aA0q_nYdNdbPYbCKAuBfpp3a8OAqovR6Q%2C1000063115%2C195.29.4.43%2C20181221093428%2CXTV100001580%2CA2FB31835FEE36C471F3BF6F5EECD33C%2C-1%2C0%2C1%2C%2C%2C2%2C1000010122%2C%2C%2C2%2C1000220050%2C0%2C1000220050%2CtMzSAlfDRg%2FnWXEicMd5wkjwJdQ%3D%2C2%2CEND&GuardEncType=2',
    );
  }

  @override
  void dispose() {
    debugPrint('Video Player State dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      _controller,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,

      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: new ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: new Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }
}
