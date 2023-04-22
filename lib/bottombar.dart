import 'package:firebase_practice/screens/feed.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'screens/account.dart';
import 'screens/home.dart';
import 'tabScreens/feedTabbars/discover.dart';
import 'screens/saved.dart';

class MyBottomBar extends StatefulWidget {
  const MyBottomBar({
    super.key,
  });

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int _currentIndex = 0;

  List<Widget> screenPages = [
    Home(),
    Saved(),
    Feed(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenPages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.grey[100], boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 5,
              spreadRadius: 0,
              offset: Offset(-4, -4))
        ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
          child: GNav(
              selectedIndex: _currentIndex,
              onTabChange: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              gap: 5,
              backgroundColor: Colors.grey[100]!,
              activeColor: Colors.grey[100]!,
              tabBackgroundColor: Colors.grey[900]!,
              padding: const EdgeInsets.all(16),
              tabBorderRadius: 100,
              color: Colors.grey[900]!,
              tabs: [
                GButton(
                    icon: _currentIndex == 0
                        ? Icons.home_rounded
                        : Icons.home_outlined,
                    text: 'Home'),
                GButton(
                    icon: _currentIndex == 1
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    text: 'Wishlist'),
                GButton(
                    icon: _currentIndex == 2
                        ? Icons.rss_feed_rounded
                        : Icons.rss_feed_outlined,
                    text: 'Feed'),
                GButton(
                    icon: _currentIndex == 3
                        ? Icons.person_rounded
                        : Icons.person_outline_rounded,
                    text: 'Account'),
              ]),
        ),
      ),
    );
  }
}
