class Show {
  String showId;
  String title;
  int startTime;
  int endTime;
  String description;

  Show(
      {this.showId,
      this.title,
      this.startTime,
      this.endTime,
      this.description});

  factory Show.fromJson(Map<String, dynamic> parsedJson) {
    return Show(
        showId: parsedJson['showId'],
        title: parsedJson['title'],
        startTime: parsedJson['startTime'],
        endTime: parsedJson['endTime'],
        description: parsedJson['description']);
  }
}
