import 'package:http/http.dart' as http;

class Auth {
  final String _apiUrl = '';

  login({required String email, required String password}) async {
    try {
      http.Response response = await http.post(Uri.parse(_apiUrl),
          body: {"email": email, "password": password});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  register({
    required String name,
    required String email,
    required String password,
  }) async {
    http.Response response = await http.post(Uri.parse(_apiUrl));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
