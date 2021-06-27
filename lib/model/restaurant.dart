class Restaurant {
  String name;
  String ranking;
  bool isClosed;
  String priceLevel;
  String description;
  String phone;
  String address;

  Restaurant(
      {this.name,
      this.ranking,
      this.isClosed,
      this.priceLevel,
      this.description,
      this.phone,
      this.address});

  Restaurant.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    ranking = json['ranking'];
    isClosed = json['is_closed'];
    priceLevel = json['price_level'];
    description = json['description'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['ranking'] = this.ranking;
    data['is_closed'] = this.isClosed;
    data['price_level'] = this.priceLevel;
    data['description'] = this.description;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}
