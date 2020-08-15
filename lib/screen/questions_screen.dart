import 'dart:convert';
import 'dart:math';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liv_city_flutter/data/feature.dart';
import 'package:liv_city_flutter/main.dart';
import 'package:liv_city_flutter/screen/chat_screen.dart';
import 'package:liv_city_flutter/screen/home_screen.dart';
import 'package:liv_city_flutter/screen/stats_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class QuestionsScreen extends StatefulWidget {
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final _random = new Random();
  int next(int min, int max) => min + _random.nextInt(max - min);

  FeatureList _features;

  void removeFeature(Feature feature) {
    _features.features.remove(feature);
  }

  Widget _displayWidget() => (_features == null)
      ? Center(
          child: CircularProgressIndicator(),
        )
      : ListView.builder(
          itemCount: _features.features.length,
          itemBuilder: (context, index) =>
              createQuestion(context, index, _features.features[index]),
        );

  Future<String> _loadPlacesJson() async {
    return await rootBundle.loadString("assets/places.json");
  }

  Future<FeatureList> _decodeJson() async {
    return FeatureList.fromJson(await jsonDecode(await _loadPlacesJson()));
  }

  Widget createQuestion(BuildContext context, int index, Feature feature) {
    return GestureDetector(
      onTap: () async {
       int object = await Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => SingleQuestionScreen(feature: feature, index: index)));
       if (object != null) {
         setState(() {
           _features.features.removeAt(object);
         });
       }
      },
      child: Container(
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
            image: AssetImage('assets/parks/' +
                (feature.properties.objectId % 4).toString() +
                '.jpg'),
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
            "Does " + feature.properties.name + " need repair?",
            style: TextStyle(color: Colors.white),
          )),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_features == null) {
      _decodeJson().then((value) => {
            setState(() {
              _features = value;
            })
          });
    }
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
            child: _displayWidget()),
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
            initialActiveIndex: 1,
            onTap: (i) {
              if (i == 0) {
                Navigator.of(context).pushReplacement(
                    NoAnimationMaterialPageRoute(
                        builder: (context) => HomeScreen()));
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

class SingleQuestionScreen extends StatefulWidget {
  final Feature feature;
  final int index;
  SingleQuestionScreen({this.feature, this.index});

  @override
  _SingleQuestionScreenState createState() =>
      _SingleQuestionScreenState(feature: feature, index: index);
}

class _SingleQuestionScreenState extends State<SingleQuestionScreen> {
  final Feature feature;
  final int index;
  _SingleQuestionScreenState({this.feature, this.index});

  double _rating = 3;
  String feedback = "";

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
                  feature.properties.name,
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Spacer(),
                  Text("How do you feel about " + feature.properties.name +"?"),
                  RatingBar(
                    initialRating: 3,
                    itemCount: 5,
                    // ignore: missing_return
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: Colors.red,
                          );
                        case 1:
                          return Icon(
                            Icons.sentiment_dissatisfied,
                            color: Colors.redAccent,
                          );
                        case 2:
                          return Icon(
                            Icons.sentiment_neutral,
                            color: Colors.amber,
                          );
                        case 3:
                          return Icon(
                            Icons.sentiment_satisfied,
                            color: Colors.lightGreen,
                          );
                        case 4:
                          return Icon(
                            Icons.sentiment_very_satisfied,
                            color: Colors.green,
                          );
                      }
                    },
                    onRatingUpdate: (rating) {
                      rating = _rating;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                  ),
                  Text("Feedback: (Optional)"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Enter feedback here."
                      ),
                      onChanged: (value) {
                        feedback = value;
                      },
                    ),
                  ),
                  Spacer(),
                ],
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(context, index);
          },
          icon: Icon(Icons.send),
          label: Text("Submit Feedback"),
        ),
      ),
    );
  }
}
