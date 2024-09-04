class GetFavoritesModel {
  bool? status;
  GetFavoritesDataModel? data;
  GetFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = GetFavoritesDataModel.fromJson(json['data']);
  }
}

class GetFavoritesDataModel {
  int? currentPage; //current_page
  List<ListDataModel> data = [];
  GetFavoritesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(ListDataModel.fromJson(element));
    });
  }
}

class ListDataModel {
  int? id;
  FavoriteProductModel? product;
  ListDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = FavoriteProductModel.fromJson(json['product']);
  }
}

class FavoriteProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice; //old_price
  dynamic discount;
  String? image;
  String? name;
  String? description;

  FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
