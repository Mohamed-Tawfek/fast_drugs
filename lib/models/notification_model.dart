class NotificationModel {
  late String name;
  late String drugName;
  late String expirationDate;
  late int quantity;
  late String phone;
  late String address;

  NotificationModel.fromJson(json) {
    name = json['FullName'];
    drugName = json['DrugName'];
    expirationDate = json['ExpirationDate'];
    quantity = json['Quantity'];
    phone = json['Phone'];
    address = json['Address'];
  }
}
