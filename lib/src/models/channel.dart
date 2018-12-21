import 'show.dart';

class Channel {
  String channelId;
  String title;
  String logo;
  List<Show> shows;
  bool hasCatchup;
  bool ottChannel;

  Channel({this.channelId, this.title, this.logo, this.shows, this.hasCatchup, this.ottChannel});

  factory Channel.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['shows'] as List;
    List<Show> showsList = list.map((i) => Show.fromJson(i)).toList();

    return Channel(
        channelId: parsedJson['channelId'],
        title: parsedJson['title'],
        logo: parsedJson['logo'],
        shows: showsList,
        hasCatchup: parsedJson['hasCatchup'],
        ottChannel: parsedJson['ottChannel']
        );
  }
}
