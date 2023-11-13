import 'package:children_name/component/my_clipper.dart';
import 'package:children_name/navigation/nav_drawer.dart';
import 'package:children_name/resource/MyStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({Key? key}) : super(key: key);

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool isFavoriteIsClicked = false;
  bool isAboutIsClicked = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController =
      TextEditingController(text: " (অ্যাপ ব্যবহারকারী) এর মতামত");
  final messageController = TextEditingController();

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
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[400],
                        border: Border(
                          left: BorderSide(color: Color(0xff7D3C98), width: 10),
                          right:
                              BorderSide(color: Color(0xff7D3C98), width: 10),
                          top: BorderSide(color: Colors.purple, width: 10),
                          bottom: BorderSide(color: Colors.purple, width: 10),
                        ),
                      ),
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "আপনার মূল্যবান মতামত\n সাদরে গ্রহণযোগ্য",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.length == 0)
                              return "অনুগ্রহ করে আপনার নাম লিখুন...";
                            else
                              return null;
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.account_circle_outlined),
                            hintText: "এখানে আপনার নাম লিখুন",
                            labelText: "নাম",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.length == 0)
                              return "অনুগ্রহ করে আপনার ইমেইল এড্রেসটি লিখুন...";
                            else if (!value.contains("@") ||
                                !value.contains("."))
                              return "অনুগ্রহ করে বৈধ ইমেইল লিখুন...";
                            else
                              return null;
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email_outlined),
                            hintText: "এখানে আপনার ইমেইল এড্রেসটি লিখুন",
                            labelText: "ইমেইল",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.length == 0)
                              return "অনুগ্রহ করে আপনার মতামত লিখুন...";
                            else
                              return null;
                          },
                          keyboardType: TextInputType.multiline,
                          minLines: 3,
                          maxLines: null,
                          controller: messageController,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            icon: Icon(Icons.message_outlined),
                            hintText: "এখানে আপনার মতামত/নামের\n তালিকা লিখুন",
                            labelText: "মতামত",
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  clearAll();
                                },
                                child: Text("মুছে ফেলুন")),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  gotoEmail();
                                },
                                child: Text("পাঠান"))
                          ],
                        )
                      ],
                    )),
              ),
            ],
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
          MyStrings.feedback,
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

  void clearAll() {
    nameController.text = "";
    emailController.text = "";
    messageController.text = "";
  }

  Future<void> gotoEmail() async {
    if (_formKey.currentState!.validate()) {
      final Email email = Email(
          body: messageController.text.toString(),
          subject: nameController.text.toString() +
              subjectController.text.toString(),
          recipients: [MyStrings.developerEmail],
          isHTML: false);
      await FlutterEmailSender.send(email);
    }
  }
}
