class Character {
  final int charId;
  final String name;
  final String img;
  final String status;
  final String nickname;
  final String portrayed;

  Character(
    this.charId, 
    this.name, 
    this.img,
    this.status,
    this.nickname,
    this.portrayed,
  );

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      json['char_id'], 
      json['name'], 
      json['img'],
      json['status'],
      json['nickname'],
      json['portrayed'],
    );
  }
}