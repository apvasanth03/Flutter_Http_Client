import 'package:http/http.dart' as http;

///
/// The exception thrown by [FSHttpClient] when an error occurs.
///
sealed class HttpClientException implements Exception {}

///
/// The exception thrown when a socket error occurs (like NetworkError etc).
///
class TransportException extends HttpClientException {
  final String message;

  TransportException(this.message);

  @override
  String toString() {
    return 'FSSocketException: $message';
  }
}

///
/// The exception thrown when a client error occurs (status code 4XX).
///
class ClientException extends HttpClientException {
  final String message;

  ClientException(this.message);

  @override
  String toString() {
    return 'FSClientException: $message';
  }
}

///
/// The exception thrown when a server error occurs (status code 5XX).
///
class ServerException extends HttpClientException {
  final String message;
  final http.StreamedResponse? response;

  ServerException(this.message, [this.response]);

  @override
  String toString() {
    if (response != null) {
      return 'FSServerException: $message, uri=$response';
    } else {
      return 'FSServerException: $message';
    }
  }
}
