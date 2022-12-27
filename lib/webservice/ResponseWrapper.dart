// ignore_for_file: constant_identifier_names, file_names

class ResponseWrapper<T> {
  static const int LOADING = 1;
  static const int COMPLETED = 2;
  static const int ERROR = 3;
  int status = LOADING;
  T? data;
  String? message;

  ResponseWrapper(this.status, this.data, this.message);

  ResponseWrapper.loading(this.message) : status = LOADING;

  ResponseWrapper.completed(this.data) : status = COMPLETED;

  ResponseWrapper.error(this.message) : status = ERROR;

  @override
  String toString() {
    return "Message: $message \nData: $data";
  }
}
