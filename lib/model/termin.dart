class Termin {
  final String id;
  final String predmet;
  final DateTime datumIVreme;
  final String userId;

  Termin({
    required this.id,
    required this.predmet,
    required this.datumIVreme,
    required this.userId,
  });

  // getUserId() {
  //   return userId;
  // }

  factory Termin.fromJson(Map<String, dynamic> json) {
    return Termin(id: json['termin id'],
        predmet: json['predmet'],
        datumIVreme: json['datum'],
        userId: json['user id']);
  }
}
