import 'package:flutter/material.dart';
import 'package:payment_teacher/loading.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.blue[900],
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        backgroundColor: Colors.blue[900],
        appBarTheme: AppBarTheme(backgroundColor: Colors.blue[900]),
      ),
      home:  const LoadingPage(),
    );
  }
}



class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // Add SliverAppBar properties as needed
            title: Text('My List'),
            floating: true,
            // Add more SliverAppBar properties as needed
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // Replace the return statement with your ListView.builder
                return ListView.builder(
                  itemCount: 10, // Example itemCount
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('Item $index'),
                    );
                  },
                );
              },
              childCount: 1, // You only have one ListView.builder in this example
            ),
          ),
        ],
      ),
    );
  }
}