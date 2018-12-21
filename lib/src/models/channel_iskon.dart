import 'show_iskon.dart';

class Channel {
  int channel_id;
  String logo_img;
  String title;
  String ontv_img;
  List<Show> shows;

  Channel({
    this.channel_id,
    this.logo_img,
    this.title,
    this.ontv_img,
    this.shows
  });

  factory Channel.fromJson(Map<String, dynamic> parsedJson) {
    Map<String, dynamic> map = parsedJson['shows'];
    List<Show> list = [];
    map.forEach((k, v) => list.add(Show.fromJson(v)));

    return Channel(
      channel_id: parsedJson['channel_id'],
      logo_img: parsedJson['logo_img'],
      title: parsedJson['title'],
      ontv_img: parsedJson['ontv_img'],
      shows: list
    );
  }

}