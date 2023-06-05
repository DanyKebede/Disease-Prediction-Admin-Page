import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminApi {
  static const String baseUrl = 'http://10.0.2.2:8000/';
  static String? authToken;

  //login and fetch token
  static Future<String?> authenticate(String username, String password) async {
    final response = await http.post(Uri.parse('${baseUrl}login/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      authToken = jsonResponse['token'];
      return null;
    } else {
      return 'Failed to authenticate';
    }
  }

//change password
  static Future<String?> changePassword(
      oldPassword, newPassword, confirmPassword) async {
    final response = await http.post(
      Uri.parse('${baseUrl}change_password/'),
      headers: {'Authorization': 'Token ${authToken ?? ''}'},
      body: {
        'old_password': oldPassword,
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      },
    );

    if (response.statusCode == 200) {
      print('Password changed successfully.');
    } else {
      final errorData = json.decode(response.body);
      return errorData['error'];
    }
  }

  static void logout() {
    authToken = null;
  }
}
