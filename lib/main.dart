import 'package:biblio/bloc/book_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
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
      home: Scaffold(
          body: SafeArea(
              child: BlocProvider(
        child: SearchPage(),
        create: (context) => BookBloc(),
      ))),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Timer _timer;
  BookBloc _bookBloc;

  @override
  void initState() {
    _bookBloc = BlocProvider.of<BookBloc>(context);
    super.initState();
  }

  void _textChanged(String q) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: 800), () {
      _bookBloc.add(BookSearched(search: q));
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
          child: BlocBuilder<BookBloc, BookState>(
            builder: (context, state) {
              if (state is BookInitial) {
                return Center(child: Text('Type a title or author to search'));
              } else if (state is BookSearchPending) {
                return Center(child: CircularProgressIndicator());
              } else if (state is BookSearchSuccess) {
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: state.books.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          child: Column(
                        children: [
                          Image.network(state.books[index].image),
                          Text('${state.books[index].title}'),
                        ],
                      ));
                    });
              } else if (state is BookSearchFailure) {
                return Center(child: Text('Error during book search'));
              }
              return null;
            },
          ),
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
