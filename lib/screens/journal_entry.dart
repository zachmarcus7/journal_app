import 'package:flutter/material.dart';
import 'package:journal/widgets/drawer.dart';


class JournalEntry extends StatefulWidget {

  String date;
  String title;
  String body;

  JournalEntry({required this.date, required this.title, required this.body});

  @override
  JournalEntryState createState() => JournalEntryState();

}

class JournalEntryState extends State<JournalEntry> {

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(widget.date),
        centerTitle: true,
        leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white
              ),
              onPressed: () => {
                Navigator.of(context).pop()
              }
            )
          ), 
        actions: <Widget> [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white
              ),
              onPressed: () => {
                Scaffold.of(context).openEndDrawer()
              }
            )
          )
        ]
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(widget.title, style: TextStyle(fontSize: 40.00)),
            Text(widget.body)
          ]
        )
      )
    );
  }

}


