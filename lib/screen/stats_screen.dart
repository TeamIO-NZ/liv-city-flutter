import 'dart:math';

import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:liv_city_flutter/main.dart';
import 'package:liv_city_flutter/screen/chat_screen.dart';
import 'package:liv_city_flutter/screen/home_screen.dart';
import 'package:liv_city_flutter/screen/questions_screen.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
                  'Charts',
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
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("Crimes rates"),
                      Container(
                        height: 200,
                        child: charts.TimeSeriesChart(
                            _createCrimesData(),
                            animate: true,
                        ),
                      ),
                      Text("\nPollution (PPM)"),
                      Container(
                        height: 200,
                        child: charts.TimeSeriesChart(
                          _createPollutionData(),
                          animate: true,
                        ),
                      ),
                    ],
                  ),
                );
              },
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

  static List<charts.Series<DatedCrimes, DateTime>> _createCrimesData() {
    final data = [
      new DatedCrimes(new DateTime(2015, 5),  1761),
      new DatedCrimes(new DateTime(2015, 12), 3003),
      new DatedCrimes(new DateTime(2016, 5),  1957),
      new DatedCrimes(new DateTime(2016, 12), 3908),
      new DatedCrimes(new DateTime(2017, 5),  2544),
      new DatedCrimes(new DateTime(2017, 12), 3829),
      new DatedCrimes(new DateTime(2018, 5),  2160),
      new DatedCrimes(new DateTime(2018, 12), 3212),
      new DatedCrimes(new DateTime(2019, 5),  1821),
      new DatedCrimes(new DateTime(2019, 12), 3540),
    ];

    return [
      new charts.Series<DatedCrimes, DateTime>(
        id: 'Crimes',
        domainFn: (DatedCrimes crimes, _) => crimes.date,
        measureFn: (DatedCrimes crimes, _) => crimes.value,
        data: data,
      )
    ];
  }

  static List<charts.Series<DatedPollution, DateTime>> _createPollutionData() {
    final data = [
      new DatedPollution(new DateTime(2015, 1),  15.3),
      new DatedPollution(new DateTime(2015, 6),  12.3),
      new DatedPollution(new DateTime(2015, 12), 15.5),

      new DatedPollution(new DateTime(2016, 1),  13.3),
      new DatedPollution(new DateTime(2016, 6),  11.2),
      new DatedPollution(new DateTime(2016, 12), 11.7),

      new DatedPollution(new DateTime(2017, 1),  14),
      new DatedPollution(new DateTime(2017, 6),  14.5),
      new DatedPollution(new DateTime(2017, 12), 10.1),

      new DatedPollution(new DateTime(2018, 1),  14.1),
      new DatedPollution(new DateTime(2018, 6),  11.2),
      new DatedPollution(new DateTime(2018, 12), 12.5),

      new DatedPollution(new DateTime(2019, 1),  14.1),
      new DatedPollution(new DateTime(2019, 6),  15.1),
      new DatedPollution(new DateTime(2019, 12), 13),
    ];

    return [
      new charts.Series<DatedPollution, DateTime>(
        id: 'Pollution',
        domainFn: (DatedPollution crimes, _) => crimes.date,
        measureFn: (DatedPollution crimes, _) => crimes.ppm,
        data: data,
      )
    ];
  }
}

class DatedCrimes {
  final DateTime date;
  final int value;

  DatedCrimes(this.date, this.value);
}

class DatedPollution {
  final DateTime date;
  final double ppm;

  DatedPollution(this.date, this.ppm);
}