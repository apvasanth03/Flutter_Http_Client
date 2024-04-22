import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:network_layer/http/exception/FSHttpClientException.dart';
import 'package:network_layer/http/interface/FSHttpClientInfo.dart';

///
/// The HttpClient class that sends HTTP requests.
///
final class FSHttpClient {
  final FSHttpClientInfo _info;

  FSHttpClient(this._info);

  /// Send a HTTP request and return the response.
  ///
  /// [request] The HTTP request to send.
  /// [parser] The function to parse the response.
  ///
  /// Throws [FSServerException] - For server errors.
  /// Throws [FSClientException] - For client errors.
  /// Throws [FSSocketException] - For network errors.
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
          throw FSServerException(
              'Server error: ${response.statusCode}', response);
        default:
          throw FSClientException('Client error: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      throw FSSocketException(e.message);
    }
  }
}
