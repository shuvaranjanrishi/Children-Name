import 'package:children_name/resource/DrawerItems.dart';
import 'package:children_name/resource/MyStrings.dart';
import 'package:children_name/navigation/nav_bottom.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
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
              child: ClipOval(child: Image.asset("assets/images/logo2.png")),
            ),
          ),
          _generateMenu(DrawerItems.drawerItemIcons[0], DrawerItems.drawerItemNames[0], 0),
          _generateMenu(DrawerItems.drawerItemIcons[1], DrawerItems.drawerItemNames[1], 2),
          _generateMenu(DrawerItems.drawerItemIcons[2], DrawerItems.drawerItemNames[2], 3),
          Divider(),
          _generateMenu(DrawerItems.drawerItemIcons[3], DrawerItems.drawerItemNames[3], 4),
          _generateMenu(DrawerItems.drawerItemIcons[4], DrawerItems.drawerItemNames[4], 5),
          _generateMenu(DrawerItems.drawerItemIcons[5], DrawerItems.drawerItemNames[5], 6),
        ],
      ),
    );
  }

  Widget _generateMenu(IconData icon, String name, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: () => {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => NavBottom(selectedIndex: index)))
      },
    );
  }
}