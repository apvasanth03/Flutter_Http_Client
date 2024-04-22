///
/// The client application must implement this interface to provide the necessary information to the [FSHttpClient].
///
abstract interface class HttpClientInfo {
  Map<String, String> headers();
}
