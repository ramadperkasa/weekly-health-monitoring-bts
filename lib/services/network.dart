import 'dart:convert';
import 'package:http/http.dart';

class NetworkHelper {
  Future getData(String url) async {
    Response response = await get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
