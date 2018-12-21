class Show {
  String title;
  String largeImg;
  int startSec;
  int endSec;

  Show({this.title, this.largeImg, this.startSec, this.endSec});

  factory Show.fromJson(Map<String, dynamic> parsedJson) {
    return Show(
        title: parsedJson['title'],
        largeImg: parsedJson['largeImg'],
        startSec: parsedJson['startSec'],
        endSec: parsedJson['endSec']);
  }
}
