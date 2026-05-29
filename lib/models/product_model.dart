class ProductModel {

  final String id;
  final String name;
  final String image;
  final double price;
  final String description;
  final String category;

  ProductModel({

    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.category,
  });

  factory ProductModel.fromMap(

    String id,
    Map<String, dynamic> data,
  ) {

    double safePrice = 0;

    final rawPrice =
        data['price'];

    if (rawPrice is int) {

      safePrice =
          rawPrice.toDouble();

    } else if (rawPrice is double) {

      safePrice =
          rawPrice;

    } else if (rawPrice is String) {

      safePrice =
          double.tryParse(
                rawPrice,
              ) ??
              0;
    }

    return ProductModel(

      id: id,

      name:
          data['name'] ?? '',

      image:
          data['image'] ?? '',

      price:
          safePrice,

      description:
          data['description'] ?? '',

      category:
          data['category'] ?? '',
    );
  }
}