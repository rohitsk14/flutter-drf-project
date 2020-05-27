class Cards {
  final int id;
  final String name;
  final String number;

  Cards({this.id, this.name, this.number});

  factory Cards.fromJson(Map<String, dynamic> json) {
    return Cards(
      id: json['id'],
      name: json['name'],
      number: json['number'],
    );
  }
}
