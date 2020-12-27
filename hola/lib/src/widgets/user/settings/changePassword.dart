import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hola/src/providers/userInfoProvider.dart';
import 'package:hola/src/requests/changePasswordRequest.dart';
import 'package:loading/indicator/ball_scale_multiple_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var color = Color.fromRGBO(255, 64, 129, 1);

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool clickedSubmit = false;
  var password;
  var validPassword = null;
  var validConfirmedPassword = null;
  var confirmedPassword;
  var savedPass = "";
  var savedConfirmedPass = "";

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character'),
  ]);

  final matching = MatchValidator(errorText: 'Passwords do not match');

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
                  'Change Password',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 40,
                ),
                passwordField(),
                SizedBox(
                  height: 40,
                ),
                confirmPasswordField(),
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

  Widget passwordField() {
    return Material(
      elevation: 8.0,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: TextFormField(
        obscureText: true,
        cursorColor: color,
        decoration: InputDecoration(
          hintText: 'New Password',
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
              Icons.lock,
              color: color,
              size: 30,
            ),
          ),
          border: InputBorder.none,
        ),
        onSaved: (myPassword) {
          this.password = myPassword;
        },
        autovalidate: true,
        validator: (myPassword) => validPassword,
        //onChanged: (password) {},
        onChanged: (myPassword) {
          savedPass = myPassword;
          setState(() {
            validPassword = passwordValidator(myPassword);
          });
        },
      ),
    );
  }

  Widget confirmPasswordField() {
    return Material(
      elevation: 8.0,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: TextFormField(
        obscureText: true,
        cursorColor: color,
        decoration: InputDecoration(
          hintText: 'Confirm New Password',
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          prefixIcon: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 0,
            child: Icon(
              Icons.lock,
              color: color,
              size: 30,
            ),
          ),
          border: InputBorder.none,
        ),
        onSaved: (myConfirmedPassword) {
          this.confirmedPassword = myConfirmedPassword;
          print(confirmedPassword);
          print(this.password);
        },
        autovalidate: true,
        validator: (confirmedPassword) => validConfirmedPassword,
        //onChanged: (password) {},
        onChanged: (confirmedPassword) {
          savedConfirmedPass = confirmedPassword;
          setState(() {
            validConfirmedPassword =
                matching.validateMatch(confirmedPassword, savedPass);
          });
        },

        // autovalidate: true,
        // validator: (myConfirmedPassword) => validPassword,
        // onChanged: (myConfirmedPassword) {
        //   savedPass = myConfirmedPassword;
        //   setState(() {
        //     validPassword = passwordValidator(myConfirmedPassword);
        //   });
        // },
      ),
    );
  }

  Widget submitButton(context) {
    UserInfoProvider user_info = Provider.of<UserInfoProvider>(context);
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 50.0,
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
            ChangeMyPassword changeName =
                ChangeMyPassword(email: myEmail, password: this.password);
            Future<Map> data = changeName.changePassword();
            // Send data to backend for authentication
            data.then(
              (value) async {
                setState(() {
                  clickedSubmit = false;
                });
                if (value != null) {
                  //print(value);

                  await setPrefStorage(password);

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

  setPrefStorage(String password) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString("password", password);
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
}
