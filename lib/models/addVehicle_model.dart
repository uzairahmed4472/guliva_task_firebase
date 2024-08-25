class AddVehicle {
  String? typeOfVehicle;
  String? nameOfVehicle;
  String? model;
  String? color;
  String? year;
  String? valueOfVehicle;

  AddVehicle({
    this.typeOfVehicle,
    this.nameOfVehicle,
    this.model,
    this.color,
    this.year,
    this.valueOfVehicle,
  });

  AddVehicle.fromJson(Map<String, dynamic> json) {
    typeOfVehicle = json['type_of_vehicle'];
    nameOfVehicle = json['name_of_vehicle'];
    model = json['model'];
    color = json['color'];
    year = json['year'];
    valueOfVehicle = json['value_of_vehicle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_of_vehicle'] = this.typeOfVehicle;
    data['name_of_vehicle'] = this.nameOfVehicle;
    data['model'] = this.model;
    data['color'] = this.color;
    data['year'] = this.year;
    data['value_of_vehicle'] = this.valueOfVehicle;

    return data;
  }
}
