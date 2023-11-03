import 'dart:ui';

import 'package:children_name/component/my_clipper.dart';
import 'package:children_name/database/db_helper.dart';
import 'package:children_name/model/name_model.dart';
import 'package:children_name/resource/MyStrings.dart';
import 'package:children_name/navigation/nav_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

class MaleNameScreen extends StatefulWidget {
  const MaleNameScreen({Key? key}) : super(key: key);

  @override
  _MaleNameScreenState createState() => _MaleNameScreenState();
}

class _MaleNameScreenState extends State<MaleNameScreen> {
  final DBHelper _dbHelper = DBHelper.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<NameModel> _maleNames = [];
  List<NameModel> _maleNameDisplay = [];

  int _totalNames = 0;

  bool isFavoriteIsClicked = false;
  bool isAboutIsClicked = false;

  @override
  void initState() {
    super.initState();
    updateListView();
    isFavoriteIsClicked = false;
    isAboutIsClicked = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: _buildAppBar(),
      ),
      body: Column(
        children: <Widget>[
          _buildSearchBar(),
          Expanded(
            child: _buildListView(),
          )
        ],
      ),
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
              isAboutIsClicked = !isAboutIsClicked;
              _scaffoldKey.currentState!.openDrawer();
            });
          },
        ),
      ),
      title: Container(
        margin: const EdgeInsets.only(top: 18.0),
        child: Text(
          MyStrings.maleName,
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20, top: 10),
          child: IconButton(
            onPressed: () {
              setState(() {
                updateListView();
                isFavoriteIsClicked = !isFavoriteIsClicked;
              });
            },
            icon: isFavoriteIsClicked
                ? const Icon(Icons.favorite, color: Colors.red, size: 26)
                : const Icon(Icons.favorite, color: Colors.white, size: 26),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: Container(
          padding: const EdgeInsets.only(bottom: 25),
          child: Text(
            "মোট নাম: " + _totalNames.toString(),
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
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

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextField(
        autofocus: false,
        onChanged: (searchText) {
          searchText = searchText.toLowerCase();
          setState(() {
            _maleNameDisplay = _maleNames.where((u) {
              var fName = u.name!.toLowerCase();
              return fName.contains(searchText);
            }).toList();
            _totalNames = _maleNameDisplay.length;
          });
        },
        // controller: _textController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: const Icon(Icons.search),
          hintText: MyStrings.searchMaleName,
        ),
      ),
    );
  }

  Widget _buildListView() {
    if (_maleNameDisplay.isNotEmpty) {
      return ListView.builder(
        itemCount: _maleNameDisplay.length,
        itemBuilder: (context, index) {
          var nameItem = _maleNameDisplay[index];
          return Card(
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.deepPurple, width: 0.5),
                borderRadius: BorderRadius.circular(5)),
            elevation: 1,
            child: ExpansionPanelList(
              elevation: 0,
              animationDuration: const Duration(seconds: 1),
              children: [
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white54,
                        child: Image.asset("assets/images/icon_boy.png"),
                      ),
                      title: Text(nameItem.name.toString() +
                          " -- " +
                          nameItem.nameEn.toString()),
                    );
                  },
                  body: Container(
                    color: const Color(0xffC39BD3),
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: ListTile(
                      title: Text("অর্থ: " + nameItem.meaning.toString()),
                      trailing: IconButton(
                        onPressed: () {
                          if (nameItem.isFavorite == true) {
                            nameItem.isFavorite = false;
                            _dbHelper.updateMaleName(nameItem);
                            showSnackBar(
                                nameItem.name! + " is removed from favorite ");
                          } else {
                            nameItem.isFavorite = true;
                            _dbHelper.updateMaleName(nameItem);
                            showSnackBar(
                                nameItem.name! + " is added to favorite ");
                          }
                          setState(() {});
                        },
                        icon: nameItem.isFavorite == true
                            ? const Icon(Icons.favorite,
                                color: Colors.red, size: 26)
                            : const Icon(Icons.favorite_border_outlined,
                                color: Colors.black38, size: 26),
                      ),
                    ),
                  ),
                  isExpanded: _maleNames[index].expanded,
                )
              ],
              expansionCallback: (int item, bool status) {
                setState(() {
                  _maleNames[index].expanded = !_maleNames[index].expanded;
                });
              },
            ),
          );
        },
      );
    } else if (_maleNameDisplay.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sentiment_dissatisfied_outlined,
              size: 40, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            MyStrings.noNameFound,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
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

  void updateListView() {
    final Future<Database> dbFuture = _dbHelper.initDb();
    try {
      dbFuture.then(
        (database) {
          if (isFavoriteIsClicked) {
            Future<List<NameModel>> nameListFuture =
                _dbHelper.getFavMaleNameList();
            nameListFuture.then(
              (newNameList) {
                setState(
                  () {
                    _maleNames = newNameList;
                    _maleNameDisplay = _maleNames;
                    _totalNames = _maleNames.length;
                    debugPrint("total data: " + _maleNames.length.toString());
                  },
                );
              },
            );
          } else {
            Future<List<NameModel>> nameListFuture =
                _dbHelper.getMaleNameList();
            nameListFuture.then((newNameList) {
              setState(() {
                _maleNames = newNameList;
                _maleNameDisplay = _maleNames;
                _totalNames = _maleNames.length;
                debugPrint("total data: " + _maleNames.length.toString());
              });
            });
          }
        },
      );
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
