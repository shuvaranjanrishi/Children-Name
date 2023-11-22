import 'package:children_name/component/my_clipper.dart';
import 'package:children_name/database/db_helper.dart';
import 'package:children_name/model/name_model.dart';
import 'package:children_name/navigation/nav_drawer.dart';
import 'package:children_name/resource/MyStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

class KrishnaNameScreen extends StatefulWidget {
  const KrishnaNameScreen({Key? key}) : super(key: key);

  @override
  _KrishnaNameScreenState createState() => _KrishnaNameScreenState();
}

class _KrishnaNameScreenState extends State<KrishnaNameScreen> {
  final DBHelper _dbHelper = DBHelper.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<NameModel> _krishnaNames = [];

  bool isAboutIsClicked = false;

  @override
  void initState() {
    super.initState();
    updateListView();
    isAboutIsClicked = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: _buildAppBar(),
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      color: Colors.white,
                      padding: EdgeInsets.all(5),
                      child: Text(
                        MyStrings.krishna_name,
                        style: TextStyle(fontSize: 20),
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                child: Expanded(
              child: ListView.builder(
                itemCount: _krishnaNames.length,
                itemBuilder: (context, index) {
                  var nameItem = _krishnaNames[index];
                  return Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                nameItem.name.toString(),
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ]),
                        Divider()
                      ]);
                },
              ),
            ))

            // )
          ],
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
          icon: Icon(Icons.menu_outlined, color: Colors.white, size: 26),
          onPressed: () {
            setState(() {
              isAboutIsClicked = !isAboutIsClicked;
              _scaffoldKey.currentState!.openDrawer();
            });
          },
        ),
      ),
      title: Container(
        margin: const EdgeInsets.only(top: 18.0),
        child: Text(
          MyStrings.krishnaName,
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

  void updateListView() {
    final Future<Database> dbFuture = _dbHelper.initDb();
    try {
      dbFuture.then((database) {
        Future<List<NameModel>> nameListFuture = _dbHelper.getKrishnaNameList();
        nameListFuture.then((newNameList) {
          setState(() {
            _krishnaNames = newNameList;
          });
        });
        // }
      });
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        Fluttertoast.showToast(
            msg: "Email already exists",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      } else if (e.isSyntaxError()) {
        Fluttertoast.showToast(
            msg: "Query Syntax error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      } else if (e.isReadOnlyError()) {
        Fluttertoast.showToast(
            msg: "Database is read only mode",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      } else if (e.isOpenFailedError()) {
        Fluttertoast.showToast(
            msg: "Open database failed",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      } else if (e.isNoSuchTableError()) {
        Fluttertoast.showToast(
            msg: "Table does not available",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      } else if (e.isDatabaseClosedError()) {
        Fluttertoast.showToast(
            msg: "Database was closed",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      } else {
        Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }
    }
  }
}
