import 'dart:convert';
import 'package:http/http.dart' as http;

const String url = 'https://mcapi.us/server/status?ip=4geek.csrv.pl';

class ServerData {
  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
