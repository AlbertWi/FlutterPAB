import 'package:flutter/material.dart';
import 'package:flutter_login/screens/bookmark_screen.dart';
import 'package:flutter_login/screens/home_screen.dart';
import 'package:flutter_login/screens/profile_screen.dart';
import 'package:flutter_login/screens/search_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          height: 70,
          child: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.search),
                text: "Search",
              ),
              Tab(
                icon: Icon(Icons.bookmark),
                text: "Download",
              ),
              Tab(
                icon: Icon(Icons.person),
                text: "Profile",
              ),
            ],
            unselectedLabelColor: Color(0xFF999999),
            labelColor: Colors.white,
            indicatorColor: Colors.transparent,
          ),
        ),
        body: const TabBarView(
          children: [
            HomeScreen(),
            SearchScreen(),
            BookmarkScreen(),
            ProfileScreen()
          ],
        ),
      ),
    );
  }
}
