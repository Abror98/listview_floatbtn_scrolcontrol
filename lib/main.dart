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
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController controller;
  final itemHeight = 80.0;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();

  }

  void _scrollListener(){
    if(controller.offset >= controller.position.maxScrollExtent && !controller.position.outOfRange){
      print("End reached");
    }
    else if(controller.offset <= controller.position.minScrollExtent && !controller.position.outOfRange){
      print("At the top");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listview Demo"),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.keyboard_arrow_up),
            onPressed: (){
              controller.animateTo(controller.offset - itemHeight, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
            },
          ),
          SizedBox(height: 8.0),
          FloatingActionButton(
            child: Icon(Icons.keyboard_arrow_down),
            onPressed: (){
              controller.animateTo(controller.offset + itemHeight, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
            },
          ),
        ],
      ),
      body: ListView.builder(
          controller: controller,
          itemCount: 50,
          itemExtent: itemHeight,
          itemBuilder: (BuildContext context, int index){
            return ListTile(
              title: Text("Item $index"),
            );
          },
    ),
    );
  }
}

