import 'package:children_name/component/my_clipper.dart';
import 'package:children_name/navigation/nav_drawer.dart';
import 'package:children_name/resource/MyStrings.dart';
import 'package:children_name/widget/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RatingScreen extends StatefulWidget {
  final RateMyApp rateMyApp;

  const RatingScreen({Key? key, required this.rateMyApp}) : super(key: key);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
                      MyStrings.rating_inspire,
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                MyStrings.how_to_rate,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              _BuildStepColumn(MyStrings.step_1, "assets/images/step_1.png"),
              SizedBox(
                height: 5,
              ),
              _BuildStepColumn(MyStrings.step_2, "assets/images/step_2.png"),
              SizedBox(
                height: 5,
              ),
              _BuildStepColumn(MyStrings.step_3, "assets/images/step_3.png"),
              SizedBox(
                height: 5,
              ),
              Center(
                child: ButtonWidget(
                  text: 'এগিয়ে যান',
                  onClicked: () => widget.rateMyApp.showRateDialog(context),
                ),
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
              // isAboutIsClicked = !isAboutIsClicked;
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

  Widget _BuildStepColumn(String step, String image) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text(
        step,
        style: TextStyle(fontSize: 16),
      ),
      Container(
        padding: EdgeInsets.all(3),
        width: MediaQuery.of(context).size.width * .80,
        height: MediaQuery.of(context).size.width * .60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: Colors.grey,
        ),
        child: Image(
          fit: BoxFit.fill,
          image: AssetImage(
            image,
          ),
        ),
      ),
    ]);
  }
}
