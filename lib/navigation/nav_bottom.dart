import 'package:children_name/resource/MyStrings.dart';
import 'package:children_name/screen/about_screen.dart';
import 'package:children_name/screen/female_name_screen.dart';
import 'package:children_name/screen/krishna_name_screen.dart';
import 'package:children_name/screen/male_name_screen.dart';
import 'package:children_name/screen/rating_screen.dart';
import 'package:children_name/screen/rashi_screen.dart';
import 'package:children_name/screen/suggetion_screen.dart';
import 'package:children_name/widget/rate_app_init_widget.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

// ignore: must_be_immutable
class NavBottom extends StatefulWidget {
  int selectedIndex = 0;

  NavBottom({required this.selectedIndex});

  @override
  State<NavBottom> createState() => _NavBottomState();
}

class _NavBottomState extends State<NavBottom> {
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
      currentIndex = widget.selectedIndex;
    });
  }

  @override
  void initState() {
    onItemTapped(widget.selectedIndex);
    super.initState();
  }

  final List<Widget> pages = [MaleNameScreen(), FemaleNameScreen()];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = _returnScreen();

    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          color: Colors.deepPurple,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                minWidth: 50,
                onPressed: () {
                  setState(() {
                    currentScreen = MaleNameScreen();
                    currentIndex = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_library_outlined,
                      color:
                      currentIndex == 0 ? Colors.white : Colors.grey,
                    ),
                    Text(
                      MyStrings.maleName,
                      style: TextStyle(
                          color: currentIndex == 0
                              ? Colors.white
                              : Colors.grey),
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 50,
                onPressed: () {
                  setState(() {
                    currentScreen = FemaleNameScreen();
                    currentIndex = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_florist_outlined,
                      color:
                      currentIndex == 1 ? Colors.white : Colors.grey,
                    ),
                    Text(
                      MyStrings.femaleName,
                      style: TextStyle(
                          color: currentIndex == 1
                              ? Colors.white
                              : Colors.grey),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _returnScreen() {
    Widget currentScreen = MaleNameScreen();
    if (currentIndex == 0) {
      currentScreen = MaleNameScreen();
    } else if (currentIndex == 1) {
      currentScreen = FemaleNameScreen();
    } else if (currentIndex == 2) {
      currentScreen = KrishnaNameScreen();
    } else if (currentIndex == 3) {
      currentScreen = RashiScreen();
    } else if (currentIndex == 4) {
      currentScreen = SuggestionScreen();
    } else if (currentIndex == 5) {
      currentScreen = RateAppInitWidget(
        builder: (rateMyApp) => RatingScreen(rateMyApp: rateMyApp),
      );
    } else if (currentIndex == 6) {
      currentScreen = AboutScreen();
    }
    return currentScreen;
  }
}
