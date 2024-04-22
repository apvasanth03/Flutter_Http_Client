import 'package:http_client/http_client.dart';

class TestFSHttpClientInfo implements HttpClientInfo {
  TestFSHttpClientInfo();

  @override
  Map<String, String> headers() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
}
