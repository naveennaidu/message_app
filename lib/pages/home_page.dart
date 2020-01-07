import 'package:flutter/material.dart';
import 'package:message_app/widgets/home_widget.dart';
import 'package:message_app/widgets/list_widget.dart';
import 'package:message_app/widgets/profile_widget.dart';

const List<String> title = ["Home", "Messages","Profile"];

class HomePage extends StatefulWidget {
  static const String routeName = 'home';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int _selectedIndex = 0;
  // You should be able to use an enum to store the current page,
  // and then also just access the title by the enum .toString() method.
  // Makes things a little bit more readable
  String _title = title[0];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _title = title[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(
        child: <Widget>[
          HomeWidget(),
          ListWidget(),
          ProfileWidget()
        ].elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text('List'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(0, 0, 0, 0.9),
        onTap: _onItemTapped,
      ),
    );
  }
}
