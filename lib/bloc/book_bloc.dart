import 'dart:async';

import 'package:biblio/book.dart';
import 'package:biblio/network.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BookInitial());
  List<Book> books;

  @override
  Stream<BookState> mapEventToState(
    BookEvent event,
  ) async* {
    if (event is BookSearched && event.search.isNotEmpty) {
      yield BookSearchPending();
      try {
        books = await fetchBook(search: event.search);
        yield BookSearchSuccess(books: books);
      } catch (_) {
        yield BookSearchFailure();
      }
    }
  }
}
