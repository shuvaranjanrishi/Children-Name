import 'package:children_name/resource/DrawerItems.dart';
import 'package:children_name/resource/MyStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(MyStrings.appName),
              accountEmail: Text(MyStrings.developerName),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset("assets/images/logo2.png"),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text("হোম"),
              selected: _selectedIndex == 0,
              onTap: () {
                changePage(0);
              },
            ),
            ListTile(
              leading: Icon(Icons.list_outlined),
              title: Text("কৃষ্ণের শতনাম"),
              selected: _selectedIndex == 1,
              onTap: () {
                changePage(1);
              },
            ),
            ListTile(
              leading: Icon(Icons.ac_unit_outlined),
              title: Text("নামের রাশি"),
              selected: _selectedIndex == 2,
              onTap: () {
                changePage(2);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.send_outlined),
              title: Text("আপনার পরামর্শ পাঠান"),
              selected: _selectedIndex == 3,
              onTap: () {
                changePage(3);
              },
            ),
            ListTile(
              leading: Icon(Icons.reviews_outlined),
              title: Text("রেটিং দিন"),
              selected: _selectedIndex == 4,
              onTap: () {
                changePage(4);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_box_outlined),
              title: Text("অ্যাপের তথ্য"),
              selected: _selectedIndex == 5,
              onTap: () {
                changePage(5);
              },
            ),
          ],
        ),
      ),
      body: DrawerItems.drawerPages.elementAt(_selectedIndex),
    );
  }
}
