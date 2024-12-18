
class Product {
  final int id;
  final String title;
  final String category;
  final double price;
  final String image;
  final String description;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.image,
    required this.description
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      price: json['price'].toDouble(),
      image: json['image'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'price': price,
      'image': image,
      'description': description,
    };
  }
}