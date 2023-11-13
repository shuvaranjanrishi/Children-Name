import 'package:children_name/component/my_clipper.dart';
import 'package:children_name/navigation/nav_drawer.dart';
import 'package:children_name/resource/MyStrings.dart';
import 'package:children_name/screen/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RatingScreen extends StatefulWidget {
  final RateMyApp rateMyApp;
  const RatingScreen({Key? key,   required this.rateMyApp}) : super(key: key);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
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
      body:  Center(
        child: buildOkButton(4),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> actionsBuilder(BuildContext context, double? stars) =>
      stars == null
          ? [buildCancelButton()]
          : [buildOkButton(stars), buildCancelButton()];

  Widget buildOkButton(double stars) => TextButton(
    child: Text('OK'),
    onPressed: () async {
      widget.rateMyApp.launchStore();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Thanks for your feedback!')),
      );

      final launchAppStore = stars >= 4;

      final event = RateMyAppEventType.rateButtonPressed;

      await widget.rateMyApp.callEvent(event);

      if (launchAppStore) {
        widget.rateMyApp.launchStore();
      }

      Navigator.of(context).pop();
    },
  );

  Widget buildCancelButton() => RateMyAppNoButton(
    widget.rateMyApp,
    text: 'CANCEL',
  );

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
          MyStrings.rating,
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