import 'package:flutter/material.dart';
import 'package:hola/src/routes/routes.dart';
import 'package:hola/src/widgets/user/ChatPages/ui/screens/parentScreen.dart';
import 'package:hola/src/widgets/user/ChatPages/ui/screens/screens.dart';

class ChatLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ParentScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
      // MessageHomeScreen(),
      routes: {
        'chat': (ctx) => ChatScreen(),
      },
    );
  }
}
