import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';  
import 'package:sqflite/sqflite.dart';
import 'package:journal/db/database_manager.dart';
import 'package:journal/db/journal_entry_dto.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/screens/journal_entry_list.dart';
import 'package:journal/screens/welcome.dart';
import 'package:journal/widgets/journal_scaffold.dart';


class App extends StatefulWidget {

  final SharedPreferences preferences;

  App({Key key, this.preferences}) : super(key: key);

  @override
  AppState createState() => AppState();

}

class AppState extends State<App> {

  Journal journal;

  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    DatabaseManager databaseManager = DatabaseManager.getInstance();
    List<Map> journalRecords = await databaseManager.journalEntries();
    final journalEntries = journalRecords.map( (record) {
      return JournalEntryDTO(
        title: record['title'],
        body: record['body'],
        rating: record['rating'],
        date: record['date']
      );
    }).toList();
    setState( () {
      journal = Journal(entries: journalEntries);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (journal == null) {
      return JournalScaffold(
        title: 'Loading',
        body: Center(child: CircularProgressIndicator())
      );
    } else {
      if (journal.isEmpty()) {
        return JournalScaffold(
          title: 'Welcome',
          body: Welcome()
        );
      } else {
        return JournalScaffold(
          title: 'Journal Entries',
          body: JournalEntryList(journal: journal)
        );
      }
    }
  }


}