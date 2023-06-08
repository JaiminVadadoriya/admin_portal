import 'package:admin_portal/pages/broadcast.dart';
import 'package:admin_portal/pages/profile.dart';
import 'package:admin_portal/pages/timeSet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../widgets/signout_drawer.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      timeSet_Page(),
      Broadcast(),
      //profile(),
    ];

    return Scaffold(
      drawer: SignoutDrawer(),

      // appBar: _selectedIndex == 0
      //     ? AppBar(
      //         title: const Text("Home"),
      //         actions: <Widget>[
      //           Container(),
      //         ],

      //       )
      //     : _selectedIndex == 1?
      //     AppBar(
      //         title: const Text("Circulars"),
      //         actions: <Widget>[
      //           Container(),
      //         ],
      //       ):

      //     AppBar(
      //         title: const Text("Profile"),
      //         actions: <Widget>[
      //           Container(),
      //         ],
      //       ),
      appBar: _selectedIndex == 0
          ? AppBar(
              title: const Text("Home"),
              actions: <Widget>[
                Container(),
              ],
            )
          : AppBar(
              title: const Text("Circulars"),
              actions: <Widget>[
                Container(),
              ],
            ),

      body: widgetOptions.elementAt(_selectedIndex),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 15.0,
        ),
        child: GNav(
          gap: 10,
          // activeColor: Theme.of(context).primaryColor,
          // tabBackgroundColor: Theme.of(context).secondaryHeaderColor,
          // onTabChange: _onItemTapped,
          tabBackgroundColor: Theme.of(context).focusColor,
          onTabChange: _onItemTapped,
          padding: EdgeInsets.all(10),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          tabs: [
            GButton(
              icon: Icons.view_list_rounded,
              text: 'Home',
            ),
            GButton(
              icon: Icons.send,
              text: 'Circulars',
            ),
            // GButton(
            //   icon: Icons.account_circle,
            //   text: 'Account',
            // ),
          ],
        ),
      ),
    );
  }
}
