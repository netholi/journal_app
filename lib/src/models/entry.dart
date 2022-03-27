class Entry {
  final String entryId;
  final String? date;
  final String? entry;

  Entry({required this.entryId, this.date, this.entry});

//from fireStore
  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
        entryId: json['entryId'], date: json['date'], entry: json['entry']);
  }

  //to firestore
  Map<String, dynamic> toMap() {
    return {'entryId': entryId, 'date': date, 'entry': entry};
  }
}
