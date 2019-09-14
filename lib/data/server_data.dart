import 'dart:convert';
import 'package:http/http.dart' as http;

const String playersUrl = 'https://api.mcsrvstat.us/2/4geek.csrv.pl';

class ServerData {
  Future getPlayersData() async {
    http.Response response = await http.get(playersUrl);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return decodedData;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
