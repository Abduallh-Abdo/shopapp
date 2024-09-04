class SearchModel {
  bool? status;
  SearchDataModel? data;
  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = SearchDataModel.fromJson(json['data']);
  }
}

class SearchDataModel {
  int? currentPage; //current_page
  List<ListSeacrhDataModel> data = [];
  SearchDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(ListSeacrhDataModel.fromJson(element));
    });
  }
}



class ListSeacrhDataModel {
  int? id;
  dynamic price;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;//in_favorites
  bool? inCart;//in_cart

  ListSeacrhDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
