class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  // Price and rating are not mutable by design.
  // Howeever, it may be better to be mutable and add methods `discountPercentage` and calcolate at the cart logic.
  // I will keep this in mind for later.
  double price;
  double rating;
  final List<String> tags;
  final String brand;
  final String availabilityStatus;
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
      returnPolicy: json['returnPolicy'],
      images: json['images'].cast<String>(),
      thumbnail: json['thumbnail'],
    );
  }

  @override
  String toString() {
    return 'Product('
        'id: $id, '
        'title: $title, '
        'description: $description, '
        'category: $category, '
        'price: $price, '
        'rating: $rating, '
        'tags: $tags, '
        'brand: $brand, '
        'availabilityStatus: $availabilityStatus, '
        'returnPolicy: $returnPolicy, '
        'images: $images, '
        'thumbnail: $thumbnail'
        ')';
  }
}
