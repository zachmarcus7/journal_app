import 'package:flutter/material.dart';
import 'new_entry.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/widgets/journal_scaffold.dart';

class Welcome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Center(child: Icon(Icons.book)),
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