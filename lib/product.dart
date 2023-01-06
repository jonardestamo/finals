class Product {
  int id;
  String name;
  String details;
  double unitPrice;

  Product({this.name, this.details, this.unitPrice});
  Product.withId({this.id, this.name, this.details, this.unitPrice});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["details"] = details;
    map["unitPrice"] = unitPrice;
    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  Product.fromObject(dynamic o) {
    this.id = int.tryParse(o["id"].toString());
    this.name = o["name"];
    this.details = o["details"];
    this.unitPrice = double.tryParse(o["unitPrice"].toString());
  }



}