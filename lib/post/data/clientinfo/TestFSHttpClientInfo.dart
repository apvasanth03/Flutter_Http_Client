import 'package:network_layer/http/interface/FSHttpClientInfo.dart';

class TestFSHttpClientInfo implements FSHttpClientInfo {
  TestFSHttpClientInfo();

  @override
  Map<String, String> headers() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
}
