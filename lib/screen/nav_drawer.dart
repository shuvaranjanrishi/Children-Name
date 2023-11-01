import 'package:children_name/resource/MyStrings.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  int _selected = 0;

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
              child: ClipOval(
                child: Image.asset("assets/images/logo2.png"),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text("হোম"),
            selected: _selected == 0,
            onTap: () => changeSelection(0),
          ),
          ListTile(
            leading: Icon(Icons.list_outlined),
            title: Text("কৃষ্ণের শতনাম"),
            selected: _selected == 1,
            onTap: () => changeSelection(1),
          ),
          ListTile(
            leading: Icon(Icons.ac_unit_outlined),
            title: Text("নামের রাশি"),
            selected: _selected == 2,
            onTap: () => changeSelection(2),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.send_outlined),
            title: Text("আপনার পরামর্শ পাঠান"),
            selected: _selected == 3,
            onTap: () => changeSelection(3),
          ),
          ListTile(
            leading: Icon(Icons.reviews_outlined),
            title: Text("রেটিং দিন"),
            selected: _selected == 4,
            onTap: () => changeSelection(4),
          ),
          ListTile(
            leading: Icon(Icons.account_box_outlined),
            title: Text("অ্যাপের তথ্য"),
            selected: _selected == 5,
            onTap: () => changeSelection(5),
          ),
        ],
      ),
    );
  }

  void changeSelection(int index) {
    setState(() {
      _selected = index;
    });
  }

  void showSnackBar(String message) {
    final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.black54,
        elevation: 0,
        content: Text(message, textAlign: TextAlign.center));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
