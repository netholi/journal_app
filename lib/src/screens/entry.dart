import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/src/models/entry.dart';
import 'package:journal_app/src/providers/entry_provider.dart';
import 'package:provider/provider.dart';

class EntryScreen extends StatefulWidget {
  final Entry? entry;
  const EntryScreen({this.entry, Key? key}) : super(key: key);

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final entryController = TextEditingController();

  @override
  void dispose() {
    entryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final entryProvider = Provider.of<EntryProvider>(context, listen: false);
    if (widget.entry != null) {
      //edit
      entryController.text = (widget.entry?.entry) ?? '';
      entryProvider.loadAll(widget.entry!);
    } else {
      //add
      entryProvider.loadAll(null);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(
        context); //bcoz we wre in build method we dont need listen =false
    return Scaffold(
      appBar: AppBar(
        title: Text(formatDate(entryProvider.date!, [MM, ' ', d, ' ', yyyy])),
        actions: [
          IconButton(
            onPressed: () {
              _pickDate(context, entryProvider).then((value) {
                if (value != null) {
                  entryProvider.changedDate = value;
                }
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
              decoration: const InputDecoration(
                labelText: 'Daily Entry',
                border: InputBorder.none,
              ),
              maxLines: 12,
              minLines: 10,
              onChanged: (String value) => entryProvider.changeEntry = value,
              controller: entryController,
            ),
            ElevatedButton(
              onPressed: () {
                entryProvider.saveEntry();
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            (widget.entry == null)
                ? Container()
                : ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    onPressed: () {
                      entryProvider.removeEntry(widget.entry!.entryId);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Delete'),
                  ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> _pickDate(
      BuildContext context, EntryProvider entryProvider) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: entryProvider.date!,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (picked != null) return picked;
  }
}
