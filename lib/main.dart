import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: MainWidget());
  }
}

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  List<Widget> _widgets = [
    CycledWidget(title: "Widget 1"),
    CycledWidget(title: "Widget 2"),
    CycledWidget(title: "Widget 3"),
  ];
  Widget _currentWidget;
  int _index;

  @override
  void initState() {
    super.initState();
    _index = 0;
    _currentWidget = _widgets[_index];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> mainContent = [
      Expanded(
        child: Container(
          alignment: Alignment.center,
          child: Text("Main Content", textScaleFactor: 3,),
        ),
      ),
      Expanded(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent)
              ),
              child: Text("Rotating Views", textScaleFactor: 2,),
            ),
            AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(child: child, scale: animation);
                },
                child: _currentWidget
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      child: Text("Prev"),
                      onPressed: () {
                        setState(() {
                          if (_index >= 1) {
                            _index -= 1;
                          }
                          _currentWidget = _widgets[_index];
                        });
                      },
                    ),
                    Spacer(),
                    RaisedButton(
                      child: Text("Next"),
                      onPressed: () {
                        setState(() {
                          if (_index + 1 < _widgets.length) {
                            _index += 1;
                          }
                          _currentWidget = _widgets[_index];
                        });
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Cycling Widgets"),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Container(
            padding: EdgeInsets.all(8),
            child: orientation == Orientation.portrait ?
              Column(children: mainContent) :
              Row(children: mainContent),
          );
        }
      ),
    );
  }
}

class CycledWidget extends StatelessWidget {
  final String title;

  CycledWidget({this.title}) : super(key: ValueKey<String>(title));

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(20),
      width: width - 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title),
      ),
    );
  }
}
