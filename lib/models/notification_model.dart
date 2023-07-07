class NotificationModel
{
late String name;
late String drugName;
late String expirationDate;
late String quantity;
late String phone;
late String address;
late String email;

NotificationModel.fromJson(json){
  print('-'*20);
  print(json);
  print('-'*20);
  name=json['FullName'];
  drugName=json['DrugName'];
  expirationDate=json['ExpirationDate'];
  quantity=json['Quantity'];
  phone=json['Phone'];
  address=json['Address'];
  email=json['donatedBy']['Email'];


}

}