class ApiError {
  String message;
  String localizedMessage;

  ApiError({this.message, this.localizedMessage});

  ApiError.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    localizedMessage = json['localizedMessage'];
  }
}
