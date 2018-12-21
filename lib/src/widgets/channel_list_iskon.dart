import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:intl/intl.dart';
import 'video_player.dart';

import '../models/channel_iskon.dart';

class ChannelList extends StatelessWidget {
  final List<Channel> _channels;

  ChannelList(this._channels);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _channels.length,
      itemBuilder: (context, int index) {
        return index % 10 == 0 ? VideoPlayer() : _buildChannel(_channels[index]);
      },
      physics: const AlwaysScrollableScrollPhysics(),
    );
  }

  Widget _buildChannel(Channel channel) {
    debugPrint('build channel ${channel.title}');
    return Stack(
      children: <Widget>[
        _buildChannelImage(channel),
        Positioned(
          child: _buildChannelOverlay(channel),
          bottom: 0,
          left: 0,
          right: 0,
        ),
      ],
    );
  }

  Widget _buildChannelImage(Channel channel) {
    String image = channel.ontv_img;
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: FutureBuilder(
        future: _loadImage(image),
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

  Widget _buildChannelOverlay(Channel channel) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        alignment: Alignment.bottomCenter,
        height: 60,
        color: Colors.red[100],
        child: Row(
          children: <Widget>[
            _buildChannelLogo(channel),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      channel.shows.elementAt(0).title,
                      overflow: TextOverflow.ellipsis,
                    ),
                    _buildProgressBar(channel)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChannelLogo(Channel channel) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: FutureBuilder(
          future: _loadImage(channel.logo_img),
          builder: (BuildContext context, AsyncSnapshot<FadeInImage> image) {
            if (image.hasData) {
              return image.data;
            } else {
              return new Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildProgressBar(Channel channel) {
    bool visible = channel.shows != null &&
        channel.shows.length > 0 &&
        channel.shows.elementAt(0) != null;
    double progress = 0;
    if (visible) {
      int now = DateTime.now().millisecondsSinceEpoch;
      int timeStart = channel.shows.elementAt(0).startSec * 1000;
      int timeEnd = channel.shows.elementAt(0).endSec * 1000;
      int showTime = timeEnd - timeStart;
      int passedTime = now - timeStart;
      progress = passedTime / showTime;
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
      fit: BoxFit.cover,
    );
  }
}
