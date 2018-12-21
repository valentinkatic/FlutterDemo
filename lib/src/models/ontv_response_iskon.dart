class OnTvResponse {
  Map<String, dynamic> list;

  OnTvResponse({this.list});

  factory OnTvResponse.fromJson(Map<String, dynamic> parsedJson) {
    return OnTvResponse(list: parsedJson['list']);
  }
}
