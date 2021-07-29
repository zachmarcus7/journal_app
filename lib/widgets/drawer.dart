import 'package:flutter/material.dart';
import 'package:journal/app.dart';
import 'package:journal/widgets/journal_scaffold.dart';


class CustomDrawer extends StatefulWidget {

  @override
  _CustomDrawerState createState() => _CustomDrawerState();

}

class _CustomDrawerState extends State<CustomDrawer> {

  double sliderValue = 1.0;
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 60,
            child: DrawerHeader(
              child: Text('Settings')
            )
          ),
          ListTile(
            leading: Text('Dark Mode'),
            trailing: Container(
              width: MediaQuery.of(context).size.width * .2,
              child: Slider(
                value: sliderValue,
                divisions: 1,
                max: 2.0,
                min: 1.0,
                onChanged: (double newSliderValue) {
                    JournalScaffoldState scaffoldState = context.findAncestorStateOfType<JournalScaffoldState>();
                    AppState appState = context.findAncestorStateOfType<AppState>();
                    newSliderValue == 1.0 ? appState.widget.preferences.setString('brightness', 'light') :
                      appState.widget.preferences.setString('brightness', 'dark');
                    setState( () {
                      sliderValue = newSliderValue;
                      scaffoldState.setBrightness();
                    });
                },
              )
            ),
          )
        ]
      )
    );
  }
  

}
