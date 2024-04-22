///
/// Http method enum.
///
enum HttpMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  delete('DELETE');

  final String name;

  const HttpMethod(this.name);
}
