// ignore_for_file: file_names

class registerCustomerHttpException implements Exception {
  final Map map;

  registerCustomerHttpException(this.map);

  @override
  String toString() {
    //return super.toString(); instance of HttpException
    return 'error in ${map['field']} field';
  }
}
