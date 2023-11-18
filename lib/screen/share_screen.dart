import 'package:children_name/component/my_clipper.dart';
import 'package:children_name/navigation/nav_drawer.dart';
import 'package:children_name/resource/MyStrings.dart';
import 'package:children_name/widget/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({Key? key}) : super(key: key);

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sWidth = MediaQuery.of(context).size.width;
    var sHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        key: _scaffoldKey,
        drawer: NavDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: _buildAppBar(),
        ),
        body: Center(
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[400],
                    border: Border(
                      left: BorderSide(color: Color(0xff7D3C98), width: 10),
                      right: BorderSide(color: Color(0xff7D3C98), width: 10),
                      top: BorderSide(color: Colors.purple, width: 10),
                      bottom: BorderSide(color: Colors.purple, width: 10),
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "অ্যাপটি শেয়ার করুন",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        Text(
                          MyStrings.appName,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_outline,
                              color: Colors.grey[600],
                              size: 70,
                            ),
                            Icon(
                              Icons.forward_outlined,
                              color: Colors.grey,
                              size: 50,
                            ),
                            Icon(
                              Icons.person_outline,
                              color: Colors.grey[600],
                              size: 70,
                            ),
                          ],
                        ),
                        Text(
                          MyStrings.share_fav,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ButtonWidget(
                    text: MyStrings.share,
                    onClicked: () => {Share.share(MyStrings.playStoreLink)}),
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.only(left: 20, top: 10),
        child: IconButton(
          icon: Icon(Icons.menu_outlined, color: Colors.white, size: 26),
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
          MyStrings.share,
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
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
