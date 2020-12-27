import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Login {
  String email;
  String password;
  Login({this.email, this.password});
  Future<Map> login() async {
    //print(json.encode({"regNo": this.registrationNo, "password": this.password}));
    try {
      var data = await http.post(
        '/user/' + this.email.toString(),
        body: json.encode({"email": email, "password": password}),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );
      print("userLoginStatus: " + json.decode(data.body)['logged'].toString());
      return json.decode(data.body);
    } catch (err) {
      print(err);
      return null;
    }
  }
}
