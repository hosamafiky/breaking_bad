class Character {
  late int id;
  late String name;
  late String birthday;
  late List<dynamic> jobs;
  late String imageUrl;
  late String status;
  late String nickname;
  late List<dynamic> appearance;
  late String actorName;
  late String category;
  late List<dynamic> betterCallSaulAppearance;

  Character.fromJson(Map<String, dynamic> json) {
    id = json["char_id"];
    name = json["name"];
    birthday = json["birthday"];
    jobs = json["occupation"];
    imageUrl = json["img"];
    status = json["status"];
    nickname = json["nickname"];
    appearance = json["appearance"];
    actorName = json["portrayed"];
    category = json["category"];
    betterCallSaulAppearance = json["better_call_saul_appearance"];
  }
}
