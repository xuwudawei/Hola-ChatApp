import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ChangeMyPassword {
  String email;
  String password;
  ChangeMyPassword({this.email, this.password});
  Future<Map> changePassword() async {
    //print(json.encode({"regNo": this.registrationNo, "password": this.password}));
    try {
      var data = await http.put(
        '/user/changePassword/' + this.email.toString(),
        body: json.encode({"email": email, "password": password}),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );
      print("New password: " + json.decode(data.body)['password'].toString());
      return json.decode(data.body);
    } catch (err) {
      print(err);
      return null;
    }
  }
}
