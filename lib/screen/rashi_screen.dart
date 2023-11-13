import 'package:children_name/component/my_clipper.dart';
import 'package:children_name/navigation/nav_drawer.dart';
import 'package:children_name/resource/MyStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RashiScreen extends StatefulWidget {
  const RashiScreen({Key? key}) : super(key: key);

  @override
  _RashiScreenState createState() => _RashiScreenState();
}

class _RashiScreenState extends State<RashiScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isFavoriteIsClicked = false;
  bool isAboutIsClicked = false;

  @override
  void initState() {
    super.initState();
    isFavoriteIsClicked = false;
    isAboutIsClicked = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: _buildAppBar(),
      ),
      body: Center(
        child: ListView(
          children: [
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
                        MyStrings.rashi_nirnoy,
                        style: TextStyle(fontSize: 20),
                      ),
                    ))
              ],
            ),
            DataTable(columns: [
              _buildHeaderRow("নং"),
              _buildHeaderRow("রাশি"),
              _buildHeaderRow("অক্ষর সূমহ"),
            ], rows: [
              _buildDataRow("১", MyStrings.rashi_1, MyStrings.letters_1),
              _buildDataRow("২", MyStrings.rashi_2, MyStrings.letters_2),
              _buildDataRow("৩", MyStrings.rashi_3, MyStrings.letters_3),
              _buildDataRow("৪", MyStrings.rashi_4, MyStrings.letters_4),
              _buildDataRow("৫", MyStrings.rashi_5, MyStrings.letters_5),
              _buildDataRow("৬", MyStrings.rashi_6, MyStrings.letters_6),
              _buildDataRow("৭", MyStrings.rashi_7, MyStrings.letters_7),
              _buildDataRow("৮", MyStrings.rashi_8, MyStrings.letters_8),
              _buildDataRow("৯", MyStrings.rashi_9, MyStrings.letters_9),
              _buildDataRow("১০", MyStrings.rashi_10, MyStrings.letters_10),
              _buildDataRow("১১", MyStrings.rashi_11, MyStrings.letters_11),
              _buildDataRow("১২", MyStrings.rashi_12, MyStrings.letters_12),
            ])
          ],
        ),
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
          MyStrings.rashi,
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

  DataColumn _buildHeaderRow(String col1) {
    return DataColumn(
        label: Text(
      col1,
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w400, color: Colors.deepPurple),
    ));
  }

  DataRow _buildDataRow(String serial, String rashi, String letters) {
    return DataRow(cells: [
      DataCell(Text(serial)),
      DataCell(Text(rashi)),
      DataCell(Text(letters)),
    ]);
  }
}
