import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:liv_city_flutter/main.dart';
import 'package:liv_city_flutter/screen/chat_screen.dart';
import 'package:liv_city_flutter/screen/home_screen.dart';
import 'package:liv_city_flutter/screen/questions_screen.dart';

class PersonalScreen extends StatefulWidget {
  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
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
                  'Personal Logs',
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
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: 400,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("Tree"),
                      leading: Icon(Icons.nature),
                    );
                  }
                ),
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
              TabItem(icon: Icons.account_circle, title: 'Personal'),
            ],
            style: TabStyle.textIn,
            initialActiveIndex: 3,
            onTap: (i) {
              if (i == 1) {
                Navigator.of(context).pushReplacement(
                    NoAnimationMaterialPageRoute(
                        builder: (context) => QuestionsScreen()));
              } else if (i == 0) {
                Navigator.of(context).pushReplacement(
                    NoAnimationMaterialPageRoute(
                        builder: (context) => HomeScreen()));
              } else if (i == 2) {
                Navigator.of(context).pushReplacement(
                    NoAnimationMaterialPageRoute(
                        builder: (context) => ChatScreen()));
              }
            }),
      ),
    );
  }
}