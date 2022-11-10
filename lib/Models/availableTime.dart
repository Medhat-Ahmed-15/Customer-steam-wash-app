// ignore_for_file: file_names

class AvailableTime {
  String id;
  String booktime;
  bool available;

  AvailableTime(this.id, this.booktime, this.available);

  AvailableTime.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    booktime = json['booktime'];
    available = json['available'];
  }
}
