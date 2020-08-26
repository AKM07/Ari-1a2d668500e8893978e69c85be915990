import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkUtil {
  static NetworkUtil instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => instance;

  final JsonDecoder decoder = new JsonDecoder();

  Future<dynamic> get(String url, {Map<String, String> map}) {
    return http.get(url, headers: map).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data " + res);
      }
      return decoder.convert(res);
    });
  }

  Future<dynamic> post(String url,
      {Map<String, String> headers, Map body, encoding}) {
    return http
        .post(url, body: body, headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data " + res);
      }
      return decoder.convert(res);
    });
  }
}
