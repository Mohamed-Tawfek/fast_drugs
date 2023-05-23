class UserModel {
  late String id;
  late String firstName;
  late String lastName;
  late String email;
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    email = json['Email'];
  }
}
