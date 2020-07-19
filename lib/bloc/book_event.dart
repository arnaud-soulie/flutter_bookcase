part of 'book_bloc.dart';

@immutable
abstract class BookEvent extends Equatable {}

class BookSearched extends BookEvent {
  final String search;
  @override
  List<Object> get props => [this.search];

  BookSearched({this.search});
}
