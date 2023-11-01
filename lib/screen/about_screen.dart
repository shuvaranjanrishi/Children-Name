import 'package:children_name/component/my_clipper.dart';
import 'package:children_name/resource/MyStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  void changeSelection(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    var sWidth = MediaQuery.of(context).size.width;
    var sHeight = MediaQuery.of(context).size.height;
    debugPrint(sHeight.toString());

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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: _buildAppBar(),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Image(
                  alignment: Alignment.topCenter,
                  image:
                      const AssetImage("assets/images/background_about2.jpg"),
                  width: sWidth,
                  height: sHeight,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(
                            "assets/images/logo2.png",
                          ),
                        ),
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                MyStrings.appName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          Text(
                            MyStrings.aboutText,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ])
                      ],
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Positioned(
                        child: Container(
                          width: sWidth,
                          height: sHeight * .20,
                          color: Colors.grey.shade400.withOpacity(.40),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            ClipPath(
                              clipper: MyDownClipper(),
                              child: Container(
                                height: sHeight * .18,
                                width: sWidth * .40,
                                color: Colors.orange,
                                child: const Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    "assets/images/myphoto.jpg",
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: const Text("Developed By"),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 5.0),
                              alignment: Alignment.center,
                              child: Text(
                                MyStrings.developerName,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              child: Text(
                                MyStrings.developerContact,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.only(left: 20, top: 10),
        child: IconButton(
          icon: const Icon(Icons.assignment_ind_outlined,
              color: Colors.white, size: 26),
          onPressed: () {
            setState(() {
              _scaffoldKey.currentState!.openDrawer();
            });
          },
        ),
      ),
      title: Container(
          margin: const EdgeInsets.only(top: 18.0),
          child: Text(
            MyStrings.appInfo,
            style: TextStyle(color: Colors.white, fontSize: 22),
          )),
      flexibleSpace: ClipPath(
        clipper: MyDownClipper(),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.deepPurple, Color(0xff7D3C98)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.clamp)),
        ),
      ),
    );
  }
}
