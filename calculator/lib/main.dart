import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int first = 0, second = 0;
  String opp = "";
  String result = "", text = "";
  void btnClicked(String btnText) {
    if (btnText == "C") {
      result = "";
      text = "";
      first = 0;
      second = 0;
    } else if (btnText == "+" ||
        btnText == "-" ||
        btnText == "x" ||
        btnText == "/") {
      first = int.parse(text);
      result = "";
      opp = btnText;
    } else if (btnText == "=") {
      second = int.parse(text);
      if (opp == "+") {
        result = (first + second).toString();
      } else if (opp == "-") {
        result = (first - second).toString();
      } else if (opp == "x") {
        result = (first * second).toString();
      } else if (opp == "/") {
        result = (first / second).toString();
      }
    } else {
      result = int.parse(text + btnText).toString();
    }
    setState(() {
      text = result;
    });
  }

  Widget customOutlineButton(String value) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => btnClicked(value),
        // padding: EdgeInsets.all(25),
        child: Text(
          value,
          style: TextStyle(fontSize: 50, color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
              color: Colors.yellow,
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(10),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w700,
                    color: Colors.red),
              ),
            )),
            Row(
              children: [
                customOutlineButton("9"),
                customOutlineButton("8"),
                customOutlineButton("7"),
                customOutlineButton("+"),
              ],
            ),
            Row(
              children: [
                customOutlineButton("6"),
                customOutlineButton("5"),
                customOutlineButton("4"),
                customOutlineButton("-"),
              ],
            ),
            Row(
              children: [
                customOutlineButton("3"),
                customOutlineButton("2"),
                customOutlineButton("1"),
                customOutlineButton("x"),
              ],
            ),
            Row(
              children: [
                customOutlineButton("C"),
                customOutlineButton("0"),
                customOutlineButton("="),
                customOutlineButton("/"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
