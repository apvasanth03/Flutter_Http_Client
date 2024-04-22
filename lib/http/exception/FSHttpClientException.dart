import 'package:http/http.dart' as http;

///
/// The exception thrown by [FSHttpClient] when an error occurs.
///
sealed class FSHttpClientException implements Exception {}

///
/// The exception thrown when a socket error occurs (like NetworkError etc).
///
class FSSocketException extends FSHttpClientException {
  final String message;

  FSSocketException(this.message);

  @override
  String toString() {
    return 'FSSocketException: $message';
  }
}

///
/// The exception thrown when a client error occurs (status code 4XX).
///
class FSClientException extends FSHttpClientException {
  final String message;

  FSClientException(this.message);

  @override
  String toString() {
    return 'FSClientException: $message';
  }
}

///
/// The exception thrown when a server error occurs (status code 5XX).
///
class FSServerException extends FSHttpClientException {
  final String message;
  final http.StreamedResponse? response;

  FSServerException(this.message, [this.response]);

  @override
  String toString() {
    if (response != null) {
      return 'FSServerException: $message, uri=$response';
    } else {
      return 'FSServerException: $message';
    }
  }
}
