import 'package:flutter/material.dart';
import 'package:hola/src/providers/BotomNav.dart';
import 'package:hola/src/widgets/user/ChatPages/ui/screens/screens.dart';
import 'package:hola/src/widgets/user/SideDrawer/userDrawer.dart';
import 'package:hola/src/widgets/user/settings/userSettings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var color = Color.fromRGBO(255, 64, 129, 1);

class ParentScreen extends StatefulWidget {
  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var selectedNav = 0;
  List<Widget> _widgetOptions = <Widget>[
    MessageHomeScreen(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    BotomNav bot = Provider.of<BotomNav>(context, listen: false);
    bot.setSave(index);
    // setState(() {
    //   selectedNav = index;
    // });
  }

  @override
  Widget build(BuildContext context) {
    BotomNav botom = Provider.of<BotomNav>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: color,
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (context) => <PopupMenuEntry>[
                PopupMenuItem(
                  key: Key('logout'),
                  value: "logout",
                  child: GestureDetector(
                    child: Text('Logout'),
                    onTap: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.setBool("logged", false);
                      pref.remove("passwrd");
                      pref.remove("email");
                      print("Logout");
                    },
                  ),
                ),
                PopupMenuItem(
                  key: Key('settings'),
                  value: "settings",
                  child: GestureDetector(
                    child: Text('Settings'),
                    onTap: () {
                      botom.setSave(1);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
              icon: Icon(Icons.more),
              onSelected: (value) {
                if (value == "settings") {
                  //Navigator.of(context).pushNamed(routeName);
                } else {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login', (route) => false);
                }
              },
            ),
          ],
          title: Text('Hola'),
        ),
      ),
      drawer: Drawer(
        child: UserDrawer(),
      ),
      body: _widgetOptions.elementAt(botom.getDefault()),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: color,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              title: Text("Chats"),
              icon: Icon(Icons.chat),
            ),
            BottomNavigationBarItem(
              title: Text("Settings"),
              icon: Icon(Icons.settings),
            ),
          ],
          onTap: _onItemTapped,
          currentIndex: botom.getDefault(),
        ),
      ),
    );
  }
}
