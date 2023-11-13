import 'package:children_name/resource/MyStrings.dart';
import 'package:children_name/navigation/nav_bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.repeat();

    Future.delayed(Duration(seconds: 5)).then((value) =>
    {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (context) => NavBottom(selectedIndex: 0)))
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background_splash.jpg"),
                  fit: BoxFit.cover,
                )),
          ),
          Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: RotationTransition(
                      turns: animation,
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 150,
                          height: 150,
                          child: Image.asset("assets/images/splash_logo.png"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    MyStrings.appName,
                    style: TextStyle(
                      fontSize: 24,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Colors.blue[100]!,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
