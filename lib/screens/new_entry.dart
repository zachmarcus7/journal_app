import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  
import 'package:journal/app.dart';
import 'package:journal/db/database_manager.dart';
import 'package:journal/db/journal_entry_dto.dart';
import 'package:journal/widgets/drawer.dart';


class NewEntry extends StatefulWidget {

  static const routeName = 'new_entry';

  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {

  final formKey = GlobalKey<FormState>();
  final journalEntryFields = JournalEntryDTO();
  int selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('New Journal Entry'),
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
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              journalEntryForm(
                label: 'Title',
                errorMessage: 'Please enter a Title',
                onSaved: (value) {journalEntryFields.title = value;},
                type: TextInputType.text
              ),
              journalEntryForm(
                label: 'Body',
                errorMessage: 'Please enter a Body',
                onSaved: (value) {journalEntryFields.body = value;},
                type: TextInputType.text
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                width: MediaQuery.of(context).size.width * 0.9,
                child: DropdownButtonFormField<int>(
                  value: selectedValue,
                  items: ratingMenuItems(maxRating: 10),
                  onChanged: (menuItem) {
                    setState(() => selectedValue = menuItem);
                  },
                  decoration:
                      InputDecoration(
                        labelText: 'Rating', 
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a Rating';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {journalEntryFields.rating = value;},
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 90,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                        overlayColor: MaterialStateProperty.all(Colors.blueGrey)
                      ),
                      onPressed: () => {
                        Navigator.of(context).pop()
                      },
                      child: Text('Cancel')
                    )
                  ),
                  Container(
                    width: 90,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                        overlayColor: MaterialStateProperty.all(Colors.blueGrey)
                      ),
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          final databaseManager = DatabaseManager.getInstance();
                          journalEntryFields.date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
                          databaseManager.saveJournalEntry(dto: journalEntryFields);
                          AppState appState = context.findAncestorStateOfType<AppState>();
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => App(preferences: appState.widget.preferences))
                          );                                      
                        }
                      },
                      child: Text('Save')
                    )
                  ),
                ],
              )
            ]
          )
        )
      )
    );
  }

  Widget journalEntryForm({BuildContext context, label, errorMessage, onSaved, type}) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: TextFormField(
        autofocus: false,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label, 
          contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          border: OutlineInputBorder()
        ),
        onSaved: onSaved,
        validator: (value) {
          if (value.isEmpty) {
            return errorMessage;
          } else {
            return null;
          }
        }
      )
    );
  }

  List<DropdownMenuItem<int>> ratingMenuItems({int maxRating}) {
    return List<DropdownMenuItem<int>>.generate(maxRating, (i) {
      return DropdownMenuItem<int>(value: i + 1, child: Text('${i + 1}'));
    });
  }

}


