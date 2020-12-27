import 'package:flutter/material.dart';
//import 'package:python_project/src/widgets/user/login/userLogin.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:email_validator/email_validator.dart' as vd;
import 'package:hola/src/requests/signUpRequests.dart';
import 'package:loading/indicator/ball_scale_multiple_indicator.dart';
import 'package:loading/loading.dart';

var color = Color.fromRGBO(255, 64, 129, 1);

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var validEmail = null;
  var validName = null;
  var validPassword = null;
  var validConfirmedPass = null;
  var savedPass = "";

  bool isLoading = false;
  bool exist = false;
  bool invalidToken = false;
  bool clickSignUp = false;

  final formKey = GlobalKey<FormState>();

  var userName;
  var email;
  var password;
  var api_key = '1';

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //leading: Icon(Icons.person_outline),
        title: Text(
          "Hola Chat",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: color,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            //decoration: BoxDecoration(),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'SignUp',
                  style: TextStyle(fontSize: 30),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 11.0),
                  child: Text(
                    "Note down your password for login purpose.",
                    style: TextStyle(color: Colors.green, fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ((exist == true)
                    ? Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "User with email exists",
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : Text("")),
                ((invalidToken == true)
                    ? Container(
                        padding: EdgeInsets.all(5),
                        child: Text("Invalid token",
                            style: TextStyle(color: Colors.red)))
                    : Text("")),
                nameField(context),
                SizedBox(
                  height: 30,
                ),
                emailField(context),
                SizedBox(
                  height: 30,
                ),
                passwordField(context),
                SizedBox(
                  height: 30,
                ),
                // confirmPasswordField(context),
                // SizedBox(
                //   height: 30,
                // ),
                registerButton(context),
                SizedBox(height: 20),
                (clickSignUp == true ? loadingWidget() : Text(" ")),
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
          //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: color)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: color)),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
        onSaved: (username) {
          this.userName = username;
        },
        autovalidate: true,
        validator: (username) {
          return validName;
        },
        onChanged: (username) {
          if (username.isEmpty) {
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

  Widget registerButton(context) {
    return ButtonTheme(
      //onTap: () => Navigator.of(context).popAndPushNamed('/login'),
      height: 50,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(horizontal: 60),
        onPressed: () {
          setState(() {
            clickSignUp = true;
            new Future.delayed(
              const Duration(seconds: 2),
              () => Navigator.of(context).pushNamed('/login'),
            );
          });
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            // Send data to the backend for registration
            SignUpRequest sign = SignUpRequest(
              email: this.email,
              api_key: this.api_key,
              username: this.userName,
              password: this.password,
              //token: this.tokens
            );
            Future<Map> data = sign.userSignUp();

            data.then((onValue) {
              if (onValue["invalid"] == true) {
                formKey.currentState.reset();
                setState(() {
                  invalidToken = true;
                  clickSignUp = false;
                });
              } else if (onValue["exist"] == true) {
                formKey.currentState.reset();
                setState(() {
                  exist = true;
                  clickSignUp = false;
                });
              } else if (onValue["success"] == true) {
                // Navigate to confirmation pag
                formKey.currentState.reset();
                setState(() {
                  clickSignUp = false;
                });
              }
            });
          }
        },
        color: color,
        child: Text(
          'Register',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  Widget passwordField(context) {
    return Material(
      elevation: 8.0,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: TextFormField(
        obscureText: true,
        cursorColor: color,
        decoration: InputDecoration(
          hintText: 'Password',
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
        onSaved: (passwordo) {
          this.password = passwordo;
        },
        autovalidate: true,
        validator: (passwordo) => validPassword,
        onChanged: (passwordo) {
          savedPass = passwordo;
          setState(() {
            validPassword = passwordValidator(passwordo);
          });
        },
      ),
    );
  }

  // Widget confirmPasswordField(context) {
  //   return Material(
  //     elevation: 8.0,
  //     borderRadius: BorderRadius.all(Radius.circular(10)),
  //     child: TextFormField(
  //       obscureText: true,
  //       cursorColor: color,
  //       decoration: InputDecoration(
  //         hintText: 'Confirm Password',
  //         contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
  //         // enabledBorder:
  //         //     OutlineInputBorder(borderSide: BorderSide(color: color)),
  //         focusedBorder:
  //             OutlineInputBorder(borderSide: BorderSide(color: color)),
  //         focusedErrorBorder:
  //             OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
  //         errorBorder:
  //             OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
  //         prefixIcon: Material(
  //           borderRadius: BorderRadius.all(Radius.circular(10)),
  //           elevation: 0,
  //           child: Icon(
  //             Icons.lock,
  //             color: color,
  //             size: 30,
  //           ),
  //         ),
  //         border: InputBorder.none,
  //       ),
  //       onSaved: (confirmedPassword) {

  //       },
  //       onChanged: (confirmedPassword) {},
  //     ),
  //   );
  // }

  Widget emailField(context) {
    return Material(
      elevation: 8.0,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: TextFormField(
        cursorColor: color,
        decoration: InputDecoration(
          hintText: 'Email',
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: color)),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          prefixIcon: Material(
            elevation: 0,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Icon(
              Icons.email,
              size: 30,
              color: color,
            ),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        ),
        onSaved: (emails) {
          this.email = emails;
        },
        autovalidate: true,
        validator: (emails) => validEmail,
        onChanged: (emails) {
          if (vd.EmailValidator.validate(emails)) {
            setState(() {
              validEmail = null;
            });
          } else {
            setState(() {
              validEmail = "Please enter a valid email";
            });
          }
        },
      ),
    );
  }

  Widget loadingWidget() {
    return Center(
      child: Loading(
        color: color,
        indicator: BallScaleMultipleIndicator(),
        size: 80,
      ),
    );
  }
}
