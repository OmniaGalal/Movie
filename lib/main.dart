import 'package:flutter/material.dart';
import 'package:moviesapp/homepage/browse/filteredMovies.dart';
import 'package:moviesapp/homepage/movies/MovieScreen.dart';
import 'package:moviesapp/shared/colors.dart';
import 'package:moviesapp/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.backcolor,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: AppColors.greycolor,
            elevation: 0,
            showSelectedLabels: true,
            showUnselectedLabels: true
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          FilteredMovies.routeName:(context)=>FilteredMovies(),
          MovieScreen.routeName:(context)=>MovieScreen(),

        },
        //initialRoute: FilteredMovies.routeName,
        home: SplashScreen());
  }
}
