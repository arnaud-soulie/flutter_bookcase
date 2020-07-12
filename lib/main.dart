import 'package:biblio/network.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'book.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BookCase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(body: SafeArea(child: SearchPage())),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Book> entries = List<Book>();
  Timer _timer;

  void _textChanged(String q) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: 800), () {
      if (q != '') {
        fetchBook(search: q).then((value) {
          setState(() {
            entries = value;
          });
        });
      } else {
        setState(() {
          entries.clear();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) => _textChanged(value),
        ),
        Expanded(
          child: entries.length != 0
              ? ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: Column(
                      children: [
                        Image.network(entries[index].image),
                        Text('${entries[index].title}'),
                      ],
                    ));
                  })
              : Center(child: Text('No result')),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
