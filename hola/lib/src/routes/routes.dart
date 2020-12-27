import 'package:flutter/material.dart';

//SplashScreen
import 'package:hola/src/widgets/user/splashScreen/splashScreen.dart';

//Login
import 'package:hola/src/widgets/user/login/userLogin.dart';

//SignUp
import 'package:hola/src/widgets/user/signup/signUp.dart';

//Chat Landing Page
import 'package:hola/src/widgets/user/ChatPages/chatLandingPage.dart';

//Change User Name
import 'package:hola/src/widgets/user/settings/changeUsername.dart';

//Change password
import 'package:hola/src/widgets/user/settings/changePassword.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => UserLogin());
      case '/login/signup':
        return MaterialPageRoute(builder: (_) => SignUp());
      case '/login/home':
        return MaterialPageRoute(builder: (_) => ChatLanding());
      case '/login/home/settings/changeUsername':
        return MaterialPageRoute(builder: (_) => ChangeUsername());
      case '/login/home/settings/changePassword':
        return MaterialPageRoute(builder: (_) => ChangePassword());
    }
  }
}
