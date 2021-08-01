import 'package:flutter/material.dart';
import 'package:journal/app.dart';
import 'package:journal/widgets/journal_scaffold.dart';


class CustomDrawer extends StatefulWidget {

  @override
  _CustomDrawerState createState() => _CustomDrawerState();

}

class _CustomDrawerState extends State<CustomDrawer> {

  late bool sliderValue;

  @override
  void initState() {
    super.initState();
    initSliderValue();
  }
  
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
          SwitchListTile(
            title: Text('Dark Mode'),
            value: sliderValue,
            onChanged: (bool newSliderValue) {
              JournalScaffoldState scaffoldState = context.findAncestorStateOfType<JournalScaffoldState>() as JournalScaffoldState;
              AppState appState = context.findAncestorStateOfType<AppState>() as AppState;
              newSliderValue ? appState.widget.preferences.setString('brightness', 'dark') :
                               appState.widget.preferences.setString('brightness', 'light');
              setState( () {
                sliderValue = newSliderValue;
                scaffoldState.setBrightness();
              });
            }
          )
        ]
      )
    );
  }
  
  void initSliderValue() {
    setState((){
      AppState appState = context.findAncestorStateOfType<AppState>() as AppState;
      String dbValue = appState.widget.preferences.getString('brightness') as String;
      sliderValue = dbValue == 'dark' ? true : false;
    });
  }

}
