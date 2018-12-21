import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:intl/intl.dart';

import '../models/channel.dart';

class ChannelList extends StatelessWidget {
  final List<Channel> _channels;

  ChannelList(this._channels);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _channels.length,
      itemBuilder: (context, int index) {
        return buildChannel(_channels[index]);
      },
      physics: const AlwaysScrollableScrollPhysics(),
    );
  }

  Widget buildChannel(Channel channel) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildChannelIcons(channel),
              _buildChannelLogo(channel),
            ],
          ),
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildChannelInfo(channel),
                _buildProgressBar(channel),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChannelIcons(Channel channel) {
    return Container(
      width: 28,
      padding: EdgeInsets.only(bottom: 2),
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Container(
            width: 16,
            height: 16,
            child: Opacity(
              opacity: channel.hasCatchup ? 1 : 0,
              child: Image.asset('assets/icons/ic_epg_rec.png'),
            ),
          ),
          Container(
            width: 16,
            height: 16,
            child: Opacity(
              opacity: channel.ottChannel ? 1 : 0,
              child: Image.asset('assets/icons/ic_epg_ott.png'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelLogo(Channel channel) {
    return Container(
      width: 65,
      height: 30,
      child: FutureBuilder(
        future: _loadImage(channel.logo),
        builder: (BuildContext context, AsyncSnapshot<FadeInImage> image) {
          if (image.hasData) {
            return image.data;
          } else {
            return new Container();
          }
        },
      ),
    );
  }

  Widget _buildChannelInfo(Channel channel) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildCurrentShow(channel),
          _buildNextShow(channel),
        ],
      ),
    );
  }

  Widget _buildCurrentShow(Channel channel) {
    String currentShow;
    if (channel == null ||
        channel.shows == null ||
        channel.shows.isEmpty ||
        channel.shows.elementAt(0) == null ||
        channel.shows.elementAt(0).showId == "-1") {
      currentShow = "Nema informacija";
    } else {
      currentShow = channel.shows.elementAt(0).title;
    }
    return Text(
      currentShow,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildNextShow(Channel channel) {
    String nextShow;
    if (channel == null ||
        channel.shows == null ||
        channel.shows.length < 2 ||
        channel.shows.elementAt(1) == null ||
        channel.shows.elementAt(1).showId == "-1") {
      nextShow = "Nema informacija";
    } else {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(
          channel.shows.elementAt(1).startTime * 1000);
      var formatter = new DateFormat("HH:mm");
      nextShow =
          '${formatter.format(date)} | ${channel.shows.elementAt(1).title}';
    }
    return Text(
      nextShow,
      style: TextStyle(
        color: Color(0xFFa4a4a4),
        fontSize: 14,
      ),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProgressBar(Channel channel) {
    bool visible = channel.shows != null &&
        channel.shows.length > 0 &&
        channel.shows.elementAt(0) != null;
    double progress = 0;
    if (visible) {
      if (channel.shows.elementAt(0).showId == "-1") {
        progress = 0;
      } else {
        int now = DateTime.now().millisecondsSinceEpoch;
        int timeStart = channel.shows.elementAt(0).startTime * 1000;
        int timeEnd = channel.shows.elementAt(0).endTime * 1000;
        int showTime = timeEnd - timeStart;
        int passedTime = now - timeStart;
        progress = passedTime / showTime;
      }
    }

    return Opacity(
      opacity: visible ? 1 : 0,
      child: Padding(
        padding: EdgeInsets.only(top: 5),
        child: SizedBox(
          height: 3,
          child: LinearProgressIndicator(
            backgroundColor: Color(0xFF606060),
            valueColor: AlwaysStoppedAnimation<Color>(
              Color(0xFFe20074),
            ),
            value: progress,
          ),
        ),
      ),
    );
  }

  Future<FadeInImage> _loadImage(String url) async {
    return FadeInImage.memoryNetwork(
      image: url,
      placeholder: kTransparentImage,
    );
  }
}
