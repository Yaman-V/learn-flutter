class Book {
  final String id;
  final String title;
  final String subtitle;
  final String authors;
  final String image;
  final String url;

  Book({
    this.id = '',
    this.title = '',
    this.subtitle = '',
    this.authors = '',
    this.image = '',
    this.url = '',
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['isbn13']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
      authors: json['authors']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
    );
  }
}
