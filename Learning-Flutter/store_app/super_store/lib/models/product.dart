class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double rating;
  final List<String> tags;
  final String? brand;
  final String availabilityStatus;
  double stock;
  final String returnPolicy;
  final List<String> images;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.tags,
    required this.brand,
    required this.availabilityStatus,
    required this.stock,
    required this.returnPolicy,
    required this.images,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      tags: json['tags'].cast<String>(),
      brand: json['brand'],
      availabilityStatus: json['availabilityStatus'],
      stock: json['stock'].toDouble(),
      returnPolicy: json['returnPolicy'],
      images: json['images'].cast<String>(),
      thumbnail: json['thumbnail'],
    );
  }

  @override
  String toString() {
    return 'Product(\n'
        'id: $id,\n'
        'title: $title,\n'
        'description: $description,\n'
        'category: $category,\n'
        'price: $price,\n'
        'rating: $rating,\n'
        'tags: $tags,\n'
        'brand: $brand,\n'
        'availabilityStatus: $availabilityStatus,\n'
        'returnPolicy: $returnPolicy,\n'
        'images: $images,\n'
        'thumbnail: $thumbnail'
        '\n)\n\n';
  }
}
