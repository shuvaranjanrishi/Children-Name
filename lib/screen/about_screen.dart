import 'package:children_name/component/my_clipper.dart';
import 'package:children_name/resource/MyStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sWidth = MediaQuery.of(context).size.width;
    var sHeight = MediaQuery.of(context).size.height;
    debugPrint(sHeight.toString());

    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Image(
              alignment: Alignment.topCenter,
              image: const AssetImage("assets/images/background_about2.jpg"),
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
                            color: Colors.white, fontWeight: FontWeight.normal),
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
    );
  }
}
