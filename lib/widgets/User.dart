class User {
  User({this.id, this.name, this.email, this.typeNeg});

  int id;
  String name;
  String email;
  String typeNeg;

  save() {
    print("User saved");
  }
}
