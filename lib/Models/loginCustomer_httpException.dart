// ignore_for_file: file_names

class loginCustomerHttpException implements Exception {
  final Map errorMap;

  loginCustomerHttpException(this.errorMap);

  Map loginErrorMap() {
    return errorMap;
  }

  String errorField() {
    return errorMap['field'];
  }

  String errorMessage() {
    return errorMap['message'];
  }
}
