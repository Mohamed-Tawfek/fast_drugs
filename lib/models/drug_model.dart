class DrugModel {
  late String id;
  late String category;
  late String name;
  late String indications;
  late String form;
  late String companyName;
  late String effectiveMaterial;
  late String howToUse;
  late String pregnantAndLactating;
  late String dose;
  late String alternatives;
  late bool scheduled;

  DrugModel.fromJson(Map<String, dynamic> json) {

    id = json["_id"];
    category = json["Category"];
    name = json["DrugName"];
    indications = json["Indications"];
    form = json["Form"];
    companyName = json["CompanyName"];
    effectiveMaterial = json["EffectiveMaterial"];
    howToUse = json["HowToUse"];
    pregnantAndLactating = json["PregnantAndLactating"];
    dose = json["Dose"];
    alternatives = json["Alternatives"];
    scheduled = json["Scheduled"];

  }
}
