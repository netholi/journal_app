import 'package:flutter/material.dart';
import 'package:journal_app/src/models/entry.dart';
import 'package:journal_app/src/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class EntryProvider with ChangeNotifier {
  final fireStoreService = FirestoreService();
  DateTime? _date;
  String? _entryText;
  String? _entryId;
  var uuid = Uuid();

  //getters

  DateTime? get date => _date;
  String? get entryText => _entryText;

  Stream<List<Entry>> get entries => fireStoreService.getEntries();

  //setters
  set changedDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  set changeEntry(String entryText) {
    _entryText = entryText;
    notifyListeners();
  }

  //finctions
  loadAll(Entry? entry) {
    if (entry != null) {
      _date = DateTime.parse(entry.date ?? DateTime.now().toString());
      _entryText = entry.entry;
      _entryId = entry.entryId;
    } else {
      _date = DateTime.now();
      _entryId = null;
      _entryText = null;
    }
  }

  saveEntry() {
    if (_entryId == null) {
      //add
      var newEntry = Entry(
          entryId: uuid.v1(),
          entry: _entryText,
          date: _date?.toIso8601String());
      fireStoreService.setEntry(newEntry);
    } else {
      //edit
      var updatedEntry = Entry(
          entryId: _entryId!,
          entry: _entryText,
          date: _date?.toIso8601String());
      fireStoreService.setEntry(updatedEntry);
    }
  }

  removeEntry(String entryId) {
    fireStoreService.removeEntry(entryId);
  }
}
