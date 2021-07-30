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
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait ? VerticalLayout(journal: widget.journal) : HorizontalLayout(journal: widget.journal);
    });
  }

  Widget layoutDecider(BuildContext context, BoxConstraints constraints) =>
    constraints.maxWidth < 500 ? VerticalLayout(journal: widget.journal) : HorizontalLayout(journal: widget.journal);
}

class VerticalLayout extends StatefulWidget {

  final Journal journal;

  VerticalLayout({this.journal});

  @override
  _VerticalLayoutState createState() => _VerticalLayoutState();

}

class _VerticalLayoutState extends State<VerticalLayout> {

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

class HorizontalLayout extends StatefulWidget {

  final Journal journal;

  HorizontalLayout({this.journal});

  @override
  _HorizontalLayoutState createState() => _HorizontalLayoutState();

}

class _HorizontalLayoutState extends State<HorizontalLayout> {

  String currentTitle = '';
  String currentBody = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: ListView.builder(   
            itemCount: widget.journal.entries.length,
            itemBuilder: (context, index) {
              return ListTile(
                trailing: Icon(Icons.more_horiz),
                title: Text(widget.journal.entries[index].title),
                subtitle: Text(widget.journal.entries[index].date),
                onTap:  () { 
                  setState(() {
                    currentTitle = widget.journal.entries[index].title;
                    currentBody = widget.journal.entries[index].body;
                  });
                }
              );
            }),
          ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              SingleChildScrollView(  
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currentTitle, style: TextStyle(fontSize: 40.00)),
                    Text(currentBody),
                    Container(
                      height: 250
                    )
                  ]
                )
              ),
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
          )
        )
      ]
    );
  }
}