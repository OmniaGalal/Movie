import 'package:flutter/material.dart';
import 'package:moviesapp/homepage/browse/browseScreen.dart';
import 'package:moviesapp/homepage/movies/MovieScreen.dart';
import 'package:moviesapp/homepage/search/searchScreen.dart';
import 'package:moviesapp/homepage/watchlist/watchList.dart';
import 'package:moviesapp/shared/colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List tabs = [MovieScreen(), SearchScreen(), BrowseScreen(), WatchScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backcolor,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.yellowcolor,
        backgroundColor: AppColors.greycolor,
        currentIndex: currentIndex,
        onTap: (indx) {
          currentIndex = indx;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              backgroundColor: AppColors.greycolor,
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder_zip_outlined), label: "Browse"),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: "WatchList"),
        ],
      ),
      body: tabs[currentIndex],
    );
  }
}
