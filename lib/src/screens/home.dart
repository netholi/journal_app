import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/src/models/entry.dart';
import 'package:journal_app/src/providers/entry_provider.dart';
import 'package:journal_app/src/screens/entry.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var entryProvider = Provider.of<EntryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Journal'),
      ),
      body: StreamBuilder<List<Entry>?>(
          initialData: [],
          stream: entryProvider.entries,
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: Icon(Icons.edit),
                    iconColor: Colors.amber,
                    title: Text(
                      formatDate(DateTime.parse(snapshot.data![index].date!),
                          [MM, ' ', d, ' ', yyyy]),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EntryScreen(
                                entry: snapshot.data![index],
                              )));
                    },
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EntryScreen()));
        },
      ),
    );
  }
}
