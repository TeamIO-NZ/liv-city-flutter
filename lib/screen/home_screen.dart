import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:liv_city_flutter/main.dart';
import 'package:liv_city_flutter/screen/chat_screen.dart';
import 'package:liv_city_flutter/screen/stats_screen.dart';
import 'package:liv_city_flutter/screen/questions_screen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          elevation: 0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'LivCity',
                textAlign: TextAlign.center,
              ),
              Visibility(
                visible: true,
                child: Text(
                  'You\'re city\'s ears',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(24.0),
                topRight: const Radius.circular(24.0),
              ),
            ),
            constraints: BoxConstraints.expand(),
            child: Column(
              children: [
                Image(
                  image: AssetImage("assets/govhack.png"),
                  height: 250,
                ),
                Spacer(),
                Column(
                  children: [
                    SignInButtonBuilder(
                      text: 'Sign in with GovHack',
                      icon: Icons.code,
                      onPressed: () {},
                      backgroundColor: Colors.blue[700],
                    ),
                  ],
                ),
                Spacer()
              ],
            )),
        bottomNavigationBar: ConvexAppBar(
            backgroundColor: Colors.white,
            color: Colors.black,
            activeColor: Colors.black,
            items: [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.map, title: 'Places'),
              TabItem(icon: Icons.chat, title: 'Feedback'),
              TabItem(icon: Icons.equalizer, title: 'Charts'),
            ],
            style: TabStyle.textIn,
            onTap: (i) {
              if (i == 1) {
                Navigator.of(context).pushReplacement(
                    NoAnimationMaterialPageRoute(
                        builder: (context) => QuestionsScreen()));
              } else if (i == 2) {
                Navigator.of(context).pushReplacement(
                    NoAnimationMaterialPageRoute(
                        builder: (context) => ChatScreen()));
              } else if (i == 3) {
                Navigator.of(context).pushReplacement(
                    NoAnimationMaterialPageRoute(
                        builder: (context) => PersonalScreen()));
              }
            }),
      ),
    );
  }
}
