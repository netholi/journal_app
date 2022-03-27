import 'package:flutter/material.dart';
import 'package:journal_app/src/models/entry.dart';

class EntryScreen extends StatelessWidget {
  final Entry? entry;
  const EntryScreen({this.entry, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entry'),
        actions: [
          IconButton(
            onPressed: () {
              _pickDate(context).then((value) {
                print(value);
              });
            },
            icon: Icon(Icons.calendar_today),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Daily Entry',
                border: InputBorder.none,
              ),
              maxLines: 12,
              minLines: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Save'),
            ),
            (entry == null)
                ? Container()
                : ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    onPressed: () {},
                    child: const Text('Delete'),
                  ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (picked != null) return picked;
  }
}
