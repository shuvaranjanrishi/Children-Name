import 'package:children_name/component/my_clipper.dart';
import 'package:children_name/database/db_helper.dart';
import 'package:children_name/model/name_model.dart';
import 'package:children_name/resource/MyStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

import 'about_screen.dart';

class KrishnaNameScreen extends StatefulWidget {
  const KrishnaNameScreen({Key? key}) : super(key: key);

  @override
  _KrishnaNameScreenState createState() => _KrishnaNameScreenState();
}

class _KrishnaNameScreenState extends State<KrishnaNameScreen> {
  final DBHelper _dbHelper = DBHelper.instance;

  List<NameModel> _femaleNames = [];
  List<NameModel> _femaleNameDisplay = [];

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
        backgroundColor: _setBackgroundColor(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: _buildAppBar(),
        ),
        body: Column(
          children: <Widget>[
            if (!isAboutIsClicked) _buildSearchBar(),
            Expanded(
              child: isAboutIsClicked ? const AboutScreen() : _buildListView(),
            )
          ],
        ));
  }

  Color _setBackgroundColor() {
    if (isAboutIsClicked) {
      return Colors.deepPurple.shade300.withOpacity(.40);
    }
    return Colors.white;
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.only(left: 20, top: 10),
        child: IconButton(
          icon: isAboutIsClicked
              ? const Icon(Icons.assignment_ind_outlined,
                  color: Colors.red, size: 26)
              : const Icon(Icons.assignment_ind_outlined,
                  color: Colors.white, size: 26),
          onPressed: () {
            setState(() {
              isAboutIsClicked = !isAboutIsClicked;
            });
          },
        ),
      ),
      title: Container(
        margin: const EdgeInsets.only(top: 18.0),
        child: isAboutIsClicked
            ? const Text(
                "অ্যাপের তথ্য",
                style: TextStyle(color: Colors.white, fontSize: 22),
              )
            : const Text(
                "মেয়েদের নাম",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20, top: 10),
          child: isAboutIsClicked
              ? null
              : IconButton(
                  onPressed: () {
                    setState(() {
                      updateListView();
                      isFavoriteIsClicked = !isFavoriteIsClicked;
                    });
                  },
                  icon: isFavoriteIsClicked
                      ? const Icon(Icons.favorite, color: Colors.red, size: 26)
                      : const Icon(Icons.favorite,
                          color: Colors.white, size: 26),
                ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: Container(
          padding: const EdgeInsets.only(bottom: 25),
          child: isAboutIsClicked
              ? const Text("")
              : Text(
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
            _femaleNameDisplay = _femaleNames.where((u) {
              var fName = u.name!.toLowerCase();
              return fName.contains(searchText);
            }).toList();
          });
          _totalNames = _femaleNameDisplay.length;
        },
        // controller: _textController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: const Icon(Icons.search),
          hintText: MyStrings.searchFemaleName,
        ),
      ),
    );
  }

  Widget _buildListView() {
    if (_femaleNameDisplay.isNotEmpty) {
      return ListView.builder(
        itemCount: _femaleNameDisplay.length,
        itemBuilder: (context, index) {
          var nameItem = _femaleNameDisplay[index];
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
                        child: Image.asset("assets/images/icon_girl.png"),
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
                            _dbHelper.updateFemaleName(nameItem);
                            showSnackBar(
                                nameItem.name! + " is removed from favorite ");
                          } else {
                            nameItem.isFavorite = true;
                            _dbHelper.updateFemaleName(nameItem);
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
                  isExpanded: _femaleNames[index].expanded,
                )
              ],
              expansionCallback: (int item, bool status) {
                setState(() {
                  _femaleNames[index].expanded = !_femaleNames[index].expanded;
                });
              },
            ),
          );
        },
      );
    } else if (_femaleNameDisplay.isEmpty) {
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
      dbFuture.then((database) {
        if (isFavoriteIsClicked) {
          Future<List<NameModel>> nameListFuture =
              _dbHelper.getFavFemaleNameList();
          nameListFuture.then((newNameList) {
            setState(() {
              _femaleNames = newNameList;
              _femaleNameDisplay = _femaleNames;
              _totalNames = _femaleNames.length;
              debugPrint("total data: " + _femaleNames.length.toString());
            });
          });
        } else {
          Future<List<NameModel>> nameListFuture =
              _dbHelper.getFemaleNameList();
          nameListFuture.then((newNameList) {
            setState(() {
              _femaleNames = newNameList;
              _femaleNameDisplay = _femaleNames;
              _totalNames = _femaleNames.length;
              debugPrint("total data: " + _femaleNames.length.toString());
            });
          });
        }
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
