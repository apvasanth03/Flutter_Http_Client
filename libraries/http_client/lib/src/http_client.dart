import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_client/src/exception/http_client_exception.dart';
import 'package:http_client/src/interface/http_client_info.dart';

///
/// The HttpClient class that sends HTTP requests.
///
final class HttpClient {
  final HttpClientInfo _info;

  HttpClient(this._info);

  /// Send a HTTP request and return the response.
  ///
  /// [request] The HTTP request to send.
  /// [parser] The function to parse the response.
  ///
  /// Throws [TransportException] - For network errors.
  /// Throws [ServerException] - For server errors.
  /// Throws [ClientException] - For client errors.
  Future<R> send<R>({
    required http.Request request,
    required R Function(dynamic json) parser,
  }) async {
    // Update Request with client information
    request.headers.addAll(_info.headers());

    // Send Request
    try {
      var response = await request.send();

      switch (response.statusCode) {
        case >= 200 && < 300:
          var body = await response.stream.bytesToString();
          var json = jsonDecode(body);
          return parser(json);
        case >= 500 && < 600:
          throw ServerException(
              'Server error: ${response.statusCode}', response);
        default:
          throw ClientException('Client error: ${response.statusCode}');
      }
    } on TransportException catch (e) {
      throw TransportException(e.message);
    }
  }
}
