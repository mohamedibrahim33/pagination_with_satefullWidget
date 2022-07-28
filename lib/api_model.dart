class Character{
  late int id;
  late String name;
  late String img;

  Character.fromJson(Map<String,dynamic> map){
    id=map['char_id'];
    name=map['name'];
    img=map['img'];
  }

}