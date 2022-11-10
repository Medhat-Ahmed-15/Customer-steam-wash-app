// ignore_for_file: file_names

class PrevLocations {
  String locationname;
  double longitude;
  double latitude;

  PrevLocations({this.locationname, this.longitude, this.latitude});

  //another constructor but with different name
  PrevLocations.fromjson(Map<String, dynamic> json) {
    locationname = json['locationname'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }
}
