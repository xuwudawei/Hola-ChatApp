import 'package:flutter/material.dart';
import 'package:hola/src/providers/BotomNav.dart';
import 'package:hola/src/providers/userInfoProvider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

var color = Color.fromRGBO(255, 64, 129, 1);
bool _tapped = false;

class UserDrawer extends StatefulWidget {
  @override
  _UserDrawerState createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  @override
  Widget build(BuildContext context) {
    //this is my provider object
    BotomNav botom = Provider.of<BotomNav>(context);
    UserInfoProvider user_info = Provider.of<UserInfoProvider>(context);
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: color),
      child: Column(
        children: [
          Container(
            color: color,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
                  child: Image.asset('assets/images/holaLogo.png'),
                ),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(right: 10)),
                    Icon(
                      Icons.person_outline,
                      color: Colors.white,
                    ),
                    Padding(padding: EdgeInsets.only(right: 5)),
                    Text(
                      ": " + user_info.getUserInfo['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(right: 10)),
                    Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    Padding(padding: EdgeInsets.only(right: 5)),
                    Text(
                      ": " + user_info.getUserInfo['email'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              ListTile(
                title: Text("Chats"),
                leading: Icon(Icons.book),
                onTap: () {
                  botom.setSave(0);
                  Navigator.of(context).pop();
                },
              ),
              Divider(),
              ListTile(
                title: Text("About the App Developer"),
                leading: Icon(Icons.person),
                onTap: () {
                  _tapped = true;
                  _myWebsite();
                },
              ),
              Divider(),
            ],
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ListTile(
                  title: Text("Settings"),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    botom.setSave(1);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10))
        ],
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://kingdavid.me';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_myWebsite() {
  if (_tapped == true) {
    _launchURL();
  }
}
