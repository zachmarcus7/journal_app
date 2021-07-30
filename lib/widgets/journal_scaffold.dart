import 'package:flutter/material.dart';
import 'package:journal/app.dart';
import 'package:journal/widgets/drawer.dart';


class JournalScaffold extends StatefulWidget {

  String title;
  Widget body;

  JournalScaffold({this.title, this.body});

  @override
  JournalScaffoldState createState() => JournalScaffoldState();

}

class JournalScaffoldState extends State<JournalScaffold> {

  Brightness brightness;

  @override
  void initState() {
    super.initState();
    setBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal Scaffold',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: brightness
      ),
      home: Scaffold(
        endDrawer: CustomDrawer(),
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
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
        body: widget.body
      )
    );
  }

  void setBrightness() {
    AppState appState = context.findAncestorStateOfType<AppState>();
    String brightnessLevel;
    if (appState.widget.preferences == null){
      brightnessLevel = null;
    } else {
      brightnessLevel = appState.widget.preferences.getString('brightness');
    }

    if (brightnessLevel != null) {
      if (brightnessLevel == 'light') {
        setState( () {
          brightness = Brightness.light;
        });
      } else {
        setState( () {
          brightness = Brightness.dark;
        });
      }
    } else {
      appState.widget.preferences.setString('brightness', 'light');
      setState( () {
        brightness = Brightness.light;
      });
    }
  }

}