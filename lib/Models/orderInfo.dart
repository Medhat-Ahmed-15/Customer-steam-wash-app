// ignore_for_file: file_names

class OrderInfo {
  String id;
  String employeename;
  String employeephonenumber;
  String orderdate;
  String booktime;
  String servicename;
  double longitude;
  double latitude;
  String locationname;
  String price;

  OrderInfo(
      {this.employeename,
      this.id,
      this.booktime,
      this.latitude,
      this.employeephonenumber,
      this.locationname,
      this.longitude,
      this.orderdate,
      this.price,
      this.servicename});

  //another constructor but with different name
  OrderInfo.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    employeename = json['customername'];
    employeephonenumber = json['customerphonenumber'];
    orderdate = json['orderdate'];
    booktime = json['booktime'];
    servicename = json['servicename'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    locationname = json['locationname'];
    price = json['price'];
  }
}
