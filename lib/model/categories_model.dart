class Categoriesmodel {
  late bool status;
  late categoriesdatamodel data;
  Categoriesmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = categoriesdatamodel.fromJson(json['data']);
  }
}

class categoriesdatamodel {
  late int current_page;
  late List<Datamodel> datamodel=[];
  categoriesdatamodel.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      datamodel.add(Datamodel.fromJson(element));
    });
  }
}

class Datamodel {
  late int id;
  late String name;
  late String image;
  Datamodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
