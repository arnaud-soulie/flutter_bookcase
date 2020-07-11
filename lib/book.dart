class Book {
  final String title;
  final String image;

  Book({this.title, this.image});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['volumeInfo']['title'],
      image: json['volumeInfo'].containsKey('imageLinks')
          ? json['volumeInfo']['imageLinks']['smallThumbnail']
          : "",
    );
  }
}
