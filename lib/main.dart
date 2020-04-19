import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      title: 'Reaction Timer',
      home: PreTest()
    );
  }
}

class PreTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar (
        title: Text ('Reaction Tester'),
      ),
      body: Column (
        children: <Widget>[
          Text ('Test how fast your reaction times are! Press the button to go to the test. '
              'There will be a red sqaure and and button. The red sqaure will turn green randomly,'
              'and then you have to quickly tap on the button'),

          RaisedButton (
            onPressed: () {
              Navigator.push(context, MaterialPageRoute (builder: (context) =>
                Test ()));
            }
          )
        ],
      ),
    );
  }
}

class Test extends StatefulWidget {
  @override
  TestStates createState() => TestStates ();

}

class TestStates extends State<Test>{
  bool isRed = true;
  final min = 1000;
  final max = 3000;
  Stopwatch time;

  @override
  void initState () {
    super.initState();

    isRed = true;
    Random rnd = new Random();
    var num = min + rnd.nextInt(max - min);
    new Timer (new Duration(milliseconds: num), _done);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Center (
        child: Column (
          children: <Widget>[
            Container (
                color: isRed ? Colors.red : Colors.green,
                width: 500.0,
                height: 500.0
            ),
            RaisedButton (
              onPressed: _pressed,
            )
          ],
        ),
      )
    );
  }

  void _pressed () {
    setState(() {
      var sec = time.elapsedMilliseconds;
      time.stop();
      if (isRed) {
        Navigator.push (context, MaterialPageRoute (builder: (context) =>
            Failed ()));
      } else {
        Navigator.push (context, MaterialPageRoute (builder: (context) =>
            Success (time: sec)));
      }
      time.reset();
    });
  }

  void _done () {
    setState(() {
      isRed = !isRed;
      time = new Stopwatch();
      time.start();
    });
  }
}

class Failed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar (
        title: Text ('You pressed to quickly!')
      ),
      body: Center (
        child: RaisedButton (
          child: Text ('Try Again?'),
          onPressed: () {
            Navigator.pop (context);
            Navigator.pop (context);
          }
        ),
      )
    );
  }
}

class Success extends StatelessWidget {

  final time;
  Success({Key key, @required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        appBar: AppBar (
            title: Text ('Success')
        ),
        body: Column (
          children: <Widget>[
            Text ('You pressed the button in $time ms.'),
            RaisedButton (
                child: Text ('Try Again?'),
                onPressed: () {
                  Navigator.pop (context);
                  Navigator.pop (context);
                }
            )
          ]
        )
    );
  }
}


