import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

bool _tapped = false;

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          ListTile(
            title: Text("Change UserName"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/login/home/settings/changeUsername');
            },
          ),
          Divider(),
          ListTile(
            title: Text("Change Password"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/login/home/settings/changePassword');
            },
          ),
          Divider(),
          ListTile(
            title: Text("Learn more about the App Developer"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              _tapped = true;
              _myWebsite();
            },
          ),
          Divider(),
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
