// ignore_for_file: file_names

class CategoryBlueprint {
  String id;
  String price;
  String description;
  String includes;
  String name;

  CategoryBlueprint({
    this.id,
    this.price,
    this.description,
    this.includes,
    this.name,
  });

  //another constructor but with different name
  CategoryBlueprint.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    description = json['description'];
    includes = json['includes'];
    name = json['name'];
  }
}
