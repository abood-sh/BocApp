class CreateCustomerRequestModel {
  final String? name;
  final String? email;

  CreateCustomerRequestModel({this.name, this.email});

  factory CreateCustomerRequestModel.fromJson(Map<String, dynamic> json) {
    return CreateCustomerRequestModel(name: json['name'], email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email};
  }
}
