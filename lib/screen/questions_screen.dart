import 'dart:math';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:liv_city_flutter/main.dart';
import 'package:liv_city_flutter/screen/chat_screen.dart';
import 'package:liv_city_flutter/screen/home_screen.dart';
import 'package:liv_city_flutter/screen/personal_screen.dart';

class QuestionsScreen extends StatefulWidget {
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final _random = new Random();
  int next(int min, int max) => min + _random.nextInt(max - min);

  Widget createQuestion(BuildContext context, int index) {
    return Container(
      height: 250,
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        image: DecorationImage(
          image: AssetImage('assets/parks/' + next(0, 4).toString() + '.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(children: <Widget>[
        Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.black38,
          ),
        ),
        Center(
            child: Text(
          "Does this park need repair?",
          style: TextStyle(color: Colors.white),
        )),
      ]),
    );
  }

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
                    'Today\'s Questions',
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
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) =>
                    createQuestion(context, index)),
          ),
        bottomNavigationBar: ConvexAppBar(
            backgroundColor: Colors.white,
            color: Colors.black,
            activeColor: Colors.black,
            items: [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.map, title: 'Places'),
              TabItem(icon: Icons.chat, title: 'Feedback'),
              TabItem(icon: Icons.account_circle, title: 'Personal'),
            ],
            style: TabStyle.textIn,
            initialActiveIndex: 1,
            onTap: (i) {
              if(i == 0) {
                Navigator.of(context).pushReplacement(NoAnimationMaterialPageRoute(builder: (context) => HomeScreen()));
              } else if (i == 2) {
                Navigator.of(context).pushReplacement(NoAnimationMaterialPageRoute(builder: (context) => ChatScreen()));
              } else if (i == 3) {
                Navigator.of(context).pushReplacement(
                    NoAnimationMaterialPageRoute(
                        builder: (context) => PersonalScreen()));
              }
            }
        ),
      ),
    );
  }
}
