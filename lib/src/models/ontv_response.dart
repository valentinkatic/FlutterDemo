import 'channel.dart';

class OnTvResponse {
  List<Channel> data;

  OnTvResponse({this.data});

  factory OnTvResponse.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<Channel> channelsList = list.map((i) => Channel.fromJson(i)).toList();

    return OnTvResponse(data: channelsList);
  }
}
