// ignore_for_file: file_names

class SMSHttpException implements Exception {
  final String messgae;

  SMSHttpException(this.messgae);

  @override
  String toString() {
    //return super.toString(); instance of HttpException
    return messgae;
  }
}
