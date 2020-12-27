import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.of(context).popAndPushNamed('/login'),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.repeated,
          colors: [
            Color.fromRGBO(255, 64, 129, 1),
            Color.fromRGBO(36, 11, 54, .9),
          ],
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
          ),
          SizedBox(
            width: 400,
            height: 200,
            child: Image.asset('assets/images/holaLogo.png'),
          ),
          SizedBox(
            height: 130,
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset("assets/images/davidlogo.png"),
          ),
        ],
      ),
    );
  }
}
