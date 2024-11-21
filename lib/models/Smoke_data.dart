class SmokeData {
  int? id;
  String date;
  int cigarettesToday;
  int cigarettesYesterday;
  int totalCigarettes;
  double moneySaved;

  SmokeData({
    this.id,
    required this.date,
    required this.cigarettesToday,
    required this.cigarettesYesterday,
    required this.totalCigarettes,
    required this.moneySaved,
  });

  // Mengubah objek ke bentuk Map untuk disimpan di SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'cigarettes_today': cigarettesToday,
      'cigarettes_yesterday': cigarettesYesterday,
      'total_cigarettes': totalCigarettes,
      'money_saved': moneySaved,
    };
  }

  // Mengubah Map dari SQLite ke objek SmokeData
  factory SmokeData.fromMap(Map<String, dynamic> map) {
    return SmokeData(
      id: map['id'],
      date: map['date'],
      cigarettesToday: map['cigarettes_today'],
      cigarettesYesterday: map['cigarettes_yesterday'],
      totalCigarettes: map['total_cigarettes'],
      moneySaved: map['money_saved'],
    );
  }
}
