import 'package:children_name/resource/MyStrings.dart';
import 'package:children_name/screen/nav_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'female_name_screen.dart';
import 'male_name_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = [
    const MaleNameScreen(),
    const FemaleNameScreen()
  ];

  int _selectedIndex = 0;

  void changeSelection(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Drawer(
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
                changeSelection(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.list_outlined),
              title: Text("কৃষ্ণের শতনাম"),
              selected: _selectedIndex == 1,
              onTap: () {
                changeSelection(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.ac_unit_outlined),
              title: Text("নামের রাশি"),
              selected: _selectedIndex == 2,
              onTap: () {
                changeSelection(2);
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.send_outlined),
              title: Text("আপনার পরামর্শ পাঠান"),
              selected: _selectedIndex == 3,
              onTap: () {
                changeSelection(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.reviews_outlined),
              title: Text("রেটিং দিন"),
              selected: _selectedIndex == 4,
              onTap: () {
                changeSelection(4);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_box_outlined),
              title: Text("অ্যাপের তথ্য"),
              selected: _selectedIndex == 5,
              onTap: () {
                changeSelection(5);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit),
              label: MyStrings.maleName),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_florist_outlined),
              label: MyStrings.femaleName),
        ],
        backgroundColor: Colors.deepPurple,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }
}
