///
/// Http method enum.
///
enum FSHttpMethod {
  GET('GET'),
  POST('POST'),
  PUT('PUT'),
  DELETE('DELETE');

  final String name;

  const FSHttpMethod(this.name);
}
