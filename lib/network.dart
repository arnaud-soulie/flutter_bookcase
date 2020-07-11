import 'dart:convert';
import 'package:http/http.dart' as http;
import 'book.dart';

Future<List<Book>> fetchBook({String search}) async {
  final List<Book> bookList = List<Book>();
  final response =
      await http.get('https://www.googleapis.com/books/v1/volumes?q=$search');
  if (response.statusCode == 200) {
    json.decode(response.body)['items'].forEach((item) {
      bookList.add(Book.fromJson(item));
    });
    return bookList;
  } else {
    throw Exception('Failed to load book information from API');
  }
}
