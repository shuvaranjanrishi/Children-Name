import 'package:children_name/resource/MyStrings.dart';
import 'package:children_name/navigation/nav_bottom.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(MyStrings.appName, style: TextStyle(color: Colors.white, fontSize: 25)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(1.0),
                  bottomRight: Radius.circular(1.0),
                ),
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage("assets/images/logo2.png")
                )
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_filled),
            title: Text(MyStrings.home),
            onTap: () => {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavBottom(selectedIndex:0)))
            },
          ),
          ListTile(
            leading: Icon(Icons.list_outlined),
            title: Text(MyStrings.krishnaName),
            onTap: () => {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavBottom(selectedIndex:2)))
            },
          ),
          ListTile(
            leading: Icon(Icons.ac_unit_outlined),
            title: Text(MyStrings.rashi),
            onTap: () => {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavBottom(selectedIndex:3)))
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.send_outlined),
            title: Text(MyStrings.feedback),
            onTap: () => {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavBottom(selectedIndex:4)))
            },
          ),
          ListTile(
            leading: Icon(Icons.rate_review_outlined),
            title: Text(MyStrings.rating),
            onTap: () => {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavBottom(selectedIndex:5)))
            },
          ) ,
          ListTile(
            leading: Icon(Icons.person_pin_outlined),
            title: Text(MyStrings.appInfo),
            onTap: () => {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavBottom(selectedIndex:6)))
            },
          )
        ],
      ),
    );
  }
}