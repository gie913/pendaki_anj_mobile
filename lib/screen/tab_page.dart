import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/palette.dart';
import 'package:pendaki_champion/screen/discovery/discovery_page.dart';
import 'package:pendaki_champion/screen/home/home_page.dart';
import 'package:pendaki_champion/screen/profile/profile_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DiscoveryPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Card(
                    color: Palette.primaryColorProd,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Icon(Icons.list_alt_rounded, color: Colors.white,),
                    ),
                  )
                ],
              ),
              label: '',
              activeIcon: Stack(
                children: [
                  Card(
                    color: Palette.primaryColorProd,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Icon(Icons.list_alt_rounded, color: Colors.orange,),
                    ),
                  )
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Profile',
              backgroundColor: Colors.green,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
