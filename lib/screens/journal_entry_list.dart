import 'package:flutter/material.dart';
import 'new_entry.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/screens/journal_entry.dart';


class JournalEntryList extends StatefulWidget {

  final Journal journal;

  JournalEntryList({this.journal});

  @override
  _JournalEntryListState createState() => _JournalEntryListState();

}

class _JournalEntryListState extends State<JournalEntryList> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        ListView.builder(
          itemCount: widget.journal.entries.length,
          itemBuilder: (context, index) {
            return ListTile(
              trailing: Icon(Icons.more_horiz),
              title: Text(widget.journal.entries[index].title),
              subtitle: Text(widget.journal.entries[index].date),
              onTap:  () => { 
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => JournalEntry(
                    title: widget.journal.entries[index].title,
                    body: widget.journal.entries[index].body,
                    date: widget.journal.entries[index].date
                  ))
                )
              }
            );
        }),  
        Container(
          margin: EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              primary: Colors.blueAccent
            ),
            onPressed: () => { 
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => NewEntry())
              )
            },
            child: Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(8),
              child: Icon(Icons.add)
            )
          )
        )
      ]
    );
  }

}