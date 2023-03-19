import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> getLocationData(String text) async {
  final String key = 'AIzaSyBM44nmxwUfdOboqx4EEenqtBZPImfZzko';
  http.Response response;
  final String url = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$text&inputtype=textquery&key=$key';

  response = await http.get(Uri.parse(url), headers: {"Content-Type": "application/json"},);

  print(jsonDecode(response.body));
  return response;
}