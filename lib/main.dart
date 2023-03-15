import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _result = 0;
  final numberController1 = TextEditingController();
  final numberController2 = TextEditingController();
  String? _selectedOperation = "+";

  void _calculate() {
    setState(() {
      String number1Str = numberController1.text.trim();
      String number2Str = numberController2.text.trim();

      double number1 = double.parse(number1Str);
      double number2 = double.parse(number2Str);
      switch (_selectedOperation) {
        case "+":
          _result = number1 + number2;
          break;
        case "-":
          _result = number1 - number2;
          break;
        case "*":
          _result = number1 * number2;
          break;
        case "/":
          _result = number1 / number2;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called,
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Calculator',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                Widget>[
              Flexible(
                  child: TextField(
                      controller: numberController1,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ], // TODO allow negative numbers + decimal numbers
                      decoration: const InputDecoration(hintText: "Type a number"),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true))),
              //Text('+'), // From first version,
              DropdownButton<String>(
                value: _selectedOperation,
                //hint: Text("Pick an operation"),
                items: <String>['+', '-', '*', '/'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedOperation = newValue;
                  });
                },
              ),
              Flexible(
                  child: TextField(
                      controller: numberController2,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(hintText: "Type a number"),
                      keyboardType: TextInputType.number)),
              ElevatedButton(onPressed: _calculate, child: const Text("=")),
              Flexible(child: Text(_result.toString())),
            ]),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods. */
    );
  }
}
