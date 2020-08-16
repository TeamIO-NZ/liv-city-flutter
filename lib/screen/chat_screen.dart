import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:liv_city_flutter/main.dart';
import 'package:liv_city_flutter/screen/home_screen.dart';
import 'package:liv_city_flutter/screen/stats_screen.dart';
import 'package:liv_city_flutter/screen/questions_screen.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
                  'Chat with Liv',
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
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return MessageTile(
                            message: "Hello", sendByMe: false);
                        break;
                      case 1:
                        return MessageTile(
                            message: "Hi", sendByMe: true);
                        break;
                      case 2:
                        return MessageTile(
                            message: "If you have time, may I ask you a question submitted by Dr Peter Ivory on pollution?", sendByMe: false);
                        break;
                      case 3:
                        return MessageTile(
                            message: "Sure", sendByMe: true);
                        break;
                      case 4:
                        return MessageTile(
                            message: "How much litter do you observer on your day to day life in your general area?", sendByMe: false);
                        break;
                      case 5:
                        return MessageTile(
                            message: "I usually see cans and small litter dissuaded in my local area. I have noticed that there are no public bins around my area.", sendByMe: true);
                        break;
                      case 6:
                        return MessageTile(
                            message: "Thank you for your answer, we will get back to you on our findings 😊", sendByMe: false);
                        break;
                      default:
                        return MessageTile(
                            message: "Test", sendByMe: (index % 2 == 0));
                    }
                  })
            ],
          ),
        ),
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
            initialActiveIndex: 2,
            onTap: (i) {
              if (i == 1) {
                Navigator.of(context).pushReplacement(
                    NoAnimationMaterialPageRoute(
                        builder: (context) => QuestionsScreen()));
              } else if (i == 0) {
                Navigator.of(context).pushReplacement(
                    NoAnimationMaterialPageRoute(
                        builder: (context) => HomeScreen()));
              } else if (i == 3) {
                Navigator.of(context).pushReplacement(
                    NoAnimationMaterialPageRoute(
                        builder: (context) => PersonalScreen()));
              }
            }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.mic),
          onPressed: () {},
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [const Color(0xff007EF4), const Color(0xff007EF4)]
                  : [const Color(0xff78909C), const Color(0xff78909C)],
              //  : [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)],
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
