import 'package:flutter/material.dart';
import 'package:hola/src/providers/BotomNav.dart';
import 'package:hola/src/providers/userInfoProvider.dart';
import 'package:hola/src/routes/routes.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool logged = false;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BotomNav()),
        ChangeNotifierProvider(
          create: (_) => UserInfoProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: logged ? '/login/home' : '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
