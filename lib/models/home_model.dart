class HomeModel {
  bool? status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

HomeDataModel.fromJson(Map<String, dynamic> json) {
    // تحويل كل عنصر في "banners" إلى كائن من نوع BannerModel
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });

    // تحويل كل عنصر في "products" إلى كائن من نوع ProductModel
    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel {
  int? id;
  String? image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice; //old_price
  dynamic discount;
  String? image;
  String? name;
  String? description;
  //  List<> images;
  bool? inFavorites; //in_favorites
  bool? inCart; //in_cart
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    // json['images'].forEach(
    //   (element) {
    //     images.add(element);
    //   },
    // );
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
