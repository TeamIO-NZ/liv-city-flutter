import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:liv_city_flutter/main.dart';
import 'package:liv_city_flutter/screen/chat_screen.dart';
import 'package:liv_city_flutter/screen/personal_screen.dart';
import 'package:liv_city_flutter/screen/questions_screen.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
          child: charts.LineChart(_createSampleData(), animate: true, behaviors: [
            new charts.RangeAnnotation([
              new charts.LineAnnotationSegment(
                  1.0, charts.RangeAnnotationAxisType.domain,
                  startLabel: 'Domain 1'),
              new charts.LineAnnotationSegment(
                  4, charts.RangeAnnotationAxisType.domain,
                  endLabel: 'Domain 2', color: charts.MaterialPalette.gray.shade200),
              new charts.LineAnnotationSegment(
                  20, charts.RangeAnnotationAxisType.measure,
                  startLabel: 'Measure 1 Start',
                  endLabel: 'Measure 1 End',
                  color: charts.MaterialPalette.gray.shade300),
              new charts.LineAnnotationSegment(
                  65, charts.RangeAnnotationAxisType.measure,
                  startLabel: 'Measure 2 Start',
                  endLabel: 'Measure 2 End',
                  color: charts.MaterialPalette.gray.shade400),
            ]),
          ])
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
          onTap: (i) {
            if(i == 1) {
              Navigator.of(context).pushReplacement(NoAnimationMaterialPageRoute(builder: (context) => QuestionsScreen()));
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

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
