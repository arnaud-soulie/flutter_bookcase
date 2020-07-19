part of 'book_bloc.dart';

@immutable
abstract class BookState extends Equatable {}

class BookInitial extends BookState {
  @override
  List<Object> get props => [];
}

class BookSearchPending extends BookState {
  @override
  List<Object> get props => [];
}

class BookSearchSuccess extends BookState {
  final List<Book> books;

  @override
  List<Object> get props => [books];

  BookSearchSuccess({this.books});
}

class BookSearchFailure extends BookState {
  @override
  List<Object> get props => [];
}
