import 'package:flutter/material.dart';
import 'package:hola/src/providers/userInfoProvider.dart';
import 'package:hola/src/requests/changeNameRequest.dart';
import 'package:loading/indicator/ball_scale_multiple_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var color = Color.fromRGBO(255, 64, 129, 1);

class ChangeUsername extends StatefulWidget {
  @override
  _ChangeUsernameState createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool clickedSubmit = false;
  var name;
  var validName = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //leading: Icon(Icons.person_outline),
        title: Text(
          "Hola",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: color,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(),
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Change Username',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 40,
                ),
                nameField(context),
                SizedBox(
                  height: 40,
                ),
                submitButton(context),
                SizedBox(height: 20),
                SizedBox(height: 30),
                //(clickedSubmit == true ? loadingWidget() : Text(" ")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget nameField(context) {
    return Material(
      elevation: 8.0,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: TextFormField(
        cursorColor: color,
        decoration: InputDecoration(
          hintText: 'Username',
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: color)),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          prefixIcon: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 0,
            child: Icon(
              Icons.person,
              color: color,
              size: 30,
            ),
          ),
          border: InputBorder.none,
        ),
        onSaved: (myName) {
          this.name = myName;
        },
        onChanged: (myName) {
          if (myName.isEmpty) {
            setState(() {
              validName = "Field required";
            });
          } else {
            setState(() {
              validName = null;
            });
          }
        },
      ),
    );
  }

  Widget submitButton(context) {
    UserInfoProvider user_info = Provider.of<UserInfoProvider>(context);
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 50.0,
      //onTap: () => Navigator.of(context).popAndPushNamed('/login/register'),
      child: RaisedButton(
        color: color,
        child: Text(
          "Submit",
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        onPressed: () async {
          setState(() {
            clickedSubmit = true;
          });
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            // print(email);
            // print(password);
            var myEmail = user_info.getUserInfo["email"];
            ChangeName changeName =
                ChangeName(email: myEmail, username: this.name);
            Future<Map> data = changeName.changeName();
            // Send data to backend for authentication
            data.then(
              (value) async {
                setState(() {
                  clickedSubmit = false;
                });
                if (value != null) {
                  //print(value);

                  await setPrefStorage(name);

                  user_info.setUserInfo(value);

                  Navigator.of(context).pushNamed('/login/home');
                  formKey.currentState.reset();

                  // Navigator.of(context).pushNamed('/student/page');

                } else {
                  //showSnackBar();
                }
              },
            );
            // If validated, Navvigate to userpage
          }
        },
      ),
    );
  }

  // Widget loadingWidget() {
  //   return Center(
  //     child: Loading(
  //       color: color,
  //       indicator: BallScaleMultipleIndicator(),
  //       size: 80,
  //     ),
  //   );
  // }

  // showSnackBar() {
  //   final snackbar = new SnackBar(
  //     duration: new Duration(seconds: 3),
  //     backgroundColor: color,
  //     content: Text(
  //       "Invalid user details or poor internet connection!",
  //       textAlign: TextAlign.center,
  //       style: TextStyle(fontSize: 15),
  //     ),
  //   );
  //   _scaffold.currentState.showSnackBar(snackbar);
  // }

  setPrefStorage(String name) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString("name", name);
  }
}
