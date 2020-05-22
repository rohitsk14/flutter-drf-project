class Cards {
  final String name;
  final String number;

  Cards({this.name, this.number});

  factory Cards.fromJson(Map<String, dynamic> json) {
    return Cards(
      name: json['name'],
      number: json['number'],
    );
  }
}
