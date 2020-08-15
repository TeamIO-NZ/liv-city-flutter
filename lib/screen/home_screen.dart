import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:liv_city_flutter/main.dart';
import 'package:liv_city_flutter/screen/chat_screen.dart';
import 'package:liv_city_flutter/screen/questions_screen.dart';

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
                    'Improve your city',
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
        ),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.white,
          color: Colors.black,
          activeColor: Colors.black,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.map, title: 'Places'),
            TabItem(icon: Icons.chat, title: 'Feedback'),
          ],
          style: TabStyle.textIn,
          onTap: (i) {
            if(i == 1) {
              Navigator.of(context).pushReplacement(NoAnimationMaterialPageRoute(builder: (context) => QuestionsScreen()));
            } else if (i == 2) {
              Navigator.of(context).pushReplacement(NoAnimationMaterialPageRoute(builder: (context) => ChatScreen()));
            }
          }
        ),
      ),
    );
  }
}
