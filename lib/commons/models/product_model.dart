import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final ProductRatingModel rating;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        price = json["price"].toDouble(),
        description = json["description"],
        category = json["category"],
        imageUrl = json["image"],
        rating = ProductRatingModel.fromJson(json["rating"]);

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        description,
        category,
        imageUrl,
        rating,
      ];
}

class ProductRatingModel extends Equatable {
  final double rate;
  final int count;

  const ProductRatingModel({required this.rate, required this.count});

  ProductRatingModel.fromJson(Map<String, dynamic> json)
      : rate = json["rate"].toDouble(),
        count = json["count"];

  @override
  List<Object?> get props => [rate, count];
}
