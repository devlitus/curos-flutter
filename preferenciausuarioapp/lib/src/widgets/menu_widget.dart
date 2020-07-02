import 'package:flutter/material.dart';
import 'package:preferenciausuarioapp/src/pages/home_page.dart';
import 'package:preferenciausuarioapp/src/pages/setting_page.dart';
class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/menu-img.jpg'),
                  fit: BoxFit.cover,
                )),
          ),
          ListTile(
            leading: Icon(Icons.pages, color: Colors.blueAccent,),
            title: Text('Home'),
            onTap: () => Navigator.pushReplacementNamed(context, HomePage.routeName),
          ),
          ListTile(
            leading: Icon(Icons.people, color: Colors.blueAccent,),
            title: Text('Peoples'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blueAccent,),
            title: Text('Settings'),
            onTap: () {
//              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, SettingPage.routeName);
            },

          ),
        ],
      ),
    );
  }
}
