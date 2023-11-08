class User {
  int? id;
  String? name;
  String? contact;
  String? description;
  String? gender;
  String? dob;
  String? qualification;
  String? age;

  User({
    this.id,
    this.name,
    this.contact,
    this.description,
    this.gender,
    this.dob,
    this.qualification,
    this.age,
  });

  Map<String, dynamic> userMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['contact'] = contact;
    mapping['description'] = description;
    mapping['gender'] = gender;
    mapping['dob'] = dob;
    mapping['qualification'] = qualification;
    mapping['age'] = age;
    return mapping;
  }
}
