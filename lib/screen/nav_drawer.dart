import 'package:children_name/resource/MyStrings.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(MyStrings.appName),
              accountEmail: Text(MyStrings.developerName),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(child: Image.asset("assets/images/logo2.png"),),
          ),),
          ListTile(
            leading: Icon(Icons.account_box_outlined),
            title: Text("About"),
            onTap: ()=>print("About Clicked"),
          ),
          ListTile(
            leading: Icon(Icons.account_box_outlined),
            title: Text("About"),
            onTap: ()=>print("About Clicked"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.reviews_outlined),
            title: Text("Send Feedback"),
            onTap: ()=>print("About Clicked"),
          ),
          ListTile(
            leading: Icon(Icons.account_box_outlined),
            title: Text("About"),
            onTap: ()=>print("About Clicked"),
          ),
        ],
      ),
    );
  }
}
