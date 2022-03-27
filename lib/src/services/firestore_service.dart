import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journal_app/src/models/entry.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //Read Entries
  Stream<List<Entry>> getEntries() {
    return _db
        .collection('entries')
        // .where('date' ,isGreaterThan: DateTime.now().add(Duration(days: -30)).toIso8601String())
        .snapshots() //snapshot() is used to get stream.. get() is used to get future
        .map((snapshot) =>
            snapshot.docs.map((doc) => Entry.fromJson(doc.data())).toList());
  }

  //Create Entry
  //update Entry
  //Upsert
  Future<void> setEntry(Entry entry) {
    var options = SetOptions(merge: true);
    return _db
        .collection('entries')
        .doc(entry.entryId)
        .set(entry.toMap(), options);
  }

  //delete Entry

  Future<void> removeEntry(String entryId) {
    return _db.collection('entries').doc(entryId).delete();
  }
}
