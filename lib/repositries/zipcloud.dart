import 'dart:convert';
import 'package:http/http.dart';

class ZipCodeApi {
  static String baseUri = 'https://zipcloud.ibsnet.co.jp/api/search';

  /// Get address from web service 'zipcloud'.
  /// [zipCode] : only number.
  static Future<String?> searchAddressFromZipCode(String zipCode) async {
    String uri = '$baseUri?zipcode=$zipCode';
    try {
      var response = await get(Uri.parse(uri));
      Map<String, dynamic> data = jsonDecode(response.body);
      //String address1 = data['results'][0]['address1'];
      String address2 = data['results'][0]['address2'];
      return address2;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
