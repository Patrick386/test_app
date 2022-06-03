import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: _DropTest()),
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _DropTest extends StatefulWidget {
  const _DropTest({Key? key}) : super(key: key);

  @override
  State<_DropTest> createState() => _DropTestState();
}

class _DropTestState extends State<_DropTest> {

  @override
  Widget build(BuildContext context) {
    return  DropTarget(
        onDragDone: (DropDoneDetails detail) async {
            print('Detail:${detail.files.first.name}');
        },
        onDragUpdated: (DropEventDetails details) {

        },
        onDragEntered: (DropEventDetails detail) {

        },
        onDragExited: (DropEventDetails detail) {

        },
        child:Container(
          width: 600,
          height: 60,
          color: Colors.amber,
          alignment: Alignment.center,
          child: const Text('Attach files by dragging & dropping, selecting them.'),
        ),
    );
  }
}
