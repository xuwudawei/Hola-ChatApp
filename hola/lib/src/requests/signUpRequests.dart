import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class SignUpRequest {
  String username;
  String api_key;
  String email;
  String password;

  //constrcutor
  SignUpRequest({this.username, this.api_key, this.email, this.password});

  Future<Map> userSignUp() async {
    var data = await http.post("/add",
        body: json.encode({
          "name": username,
          "api_key": api_key,
          "email": email,
          "password": password
        }),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    print(json.decode(data.body));
    return json.decode(data.body);
  }
}
