import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hola/src/providers/userInfoProvider.dart';
import 'package:hola/src/requests/loginRequest.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart' as vd;

var color = Color.fromRGBO(255, 64, 129, 1);

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  var validPassword = null;
  var validEmail = null;
  var email;
  var password;
  bool invalid = false;
  bool exist = true;
  bool clickedLogin = false;

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
        //leading: Icon(Icons.person_outline) ,
        title: Text(
          "Hola Chat",
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
                  'User Login',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 40,
                ),
                ((invalid == true)
                    ? Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Invalid email or password",
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : Text("")),
                ((exist != true)
                    ? Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "No such account exists",
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : Text("")),
                emailField(context),
                SizedBox(
                  height: 40,
                ),
                passwordField(context),
                SizedBox(
                  height: 40,
                ),
                loginField(context),
                // FlatButton(
                //   padding: EdgeInsets.symmetric(horizontal: 60),
                //   onPressed: () =>
                //       Navigator.popAndPushNamed(context, '/login/home'),
                //   color: color,
                //   child: Text(
                //     'Login',
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white,
                //       fontSize: 22,
                //     ),
                //   ),
                // ),

                // GestureDetector(
                //   onTap: () => Navigator.of(context).pushNamed('/login/home'),
                //   child: loginButton(),
                // ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('/login/signup'),
                  child: Text(
                    "Click here to sign up",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.popAndPushNamed(context, 'student/resetPassword');
                //   },
                //   child: Text(
                //     "Forgot Password?",
                //     style: TextStyle(
                //         decoration: TextDecoration.underline,
                //         color: color,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 16),
                //   ),
                // ),
                SizedBox(height: 30),
                //(clickedLogin == true ? loadingWidget() : Text("")),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
        onSaved: (password) {
          this.password = password;
        },
        onChanged: (data) {
          setState(() {
            invalid = false;
            exist = true;
          });
        },
      ),
    );
  }

  Widget loginField(context) {
    final user = Provider.of<UserInfoProvider>(context);
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 50.0,
      child: RaisedButton(
        color: color,
        child: Text(
          "login",
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('/login/home');
          // setState(() {
          //   clickedLogin = true;
          // });
          // if (formKey.currentState.validate()) {
          //   formKey.currentState.save();
          //   // print(email);
          //   // print(password);
          //   Login login = Login(email: this.email, password: this.password);
          //   Future<Map> data = login.login();
          //   // Send data to backend for authentication
          //   data.then(
          //     (value) async {
          //       setState(() {
          //         clickedLogin = false;
          //       });
          //       if (value != null) {
          //         //print(value);

          //         if (value["logged"] == true) {
          //           await setPrefStorage(email, password);

          //           user.setUserInfo(value);

          //           Navigator.of(context).pushNamed('/login/home');
          //           formKey.currentState.reset();

          //           // Navigator.of(context).pushNamed('/student/page');
          //         }
          //       } else {
          //         //showSnackBar();
          //       }
          //     },
          //   );
          //   // If validated, Navvigate to userpage
          // }
        },
      ),
    );
  }

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

  setPrefStorage(String email, String password) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool("logged", true);
    sharedPref.setString("email", email);
    sharedPref.setString("password", password);
  }

  // Widget loadingWidget() {
  //   return Center(
  //     child: Loading(
  //       color: Colors.pink,
  //       indicator: BallSpinFadeLoaderIndicator(),
  //       size: 50,
  //     ),
  //   );
  // }
}
