import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/api/api_manager.dart';
import 'package:moviesapp/models/browse.dart';

import 'filteredMovies.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Browse Categorey",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Expanded(
                child: FutureBuilder<Browse?>(
                    future: ApiManager.fetchGenres(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text("Error: ${snapshot.error}",
                                style: TextStyle(color: Colors.white)));
                      } else if (snapshot.hasData &&
                          snapshot.data!.genres != null) {
                        print('ooooooooooo');
                        return
                          GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: .15,
                                    crossAxisSpacing: .01),
                            itemCount: snapshot.data!.genres!.length,
                            itemBuilder: (context, index) {
                              final genre = snapshot.data!.genres![index];
                             return InkWell(
                               onTap: (){
                                 Navigator.pushNamed(context,FilteredMovies.routeName,arguments: snapshot.data!.genres![index].id);
                               },
                               child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image(
                                        image: AssetImage(
                                            "assets/images/categorey.png")),
                                    Text(
                                      "${genre.name}",
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(1),
                                          fontSize: 22),
                                    )
                                  ],
                                ),
                             );


                              //print("${snapshot.data![index]!.name}");

                            });
                      }
                      if (snapshot.hasError) {
                        return Text(
                          "ERROR",
                          style: TextStyle(color: Colors.white),
                        );
                      }
                      return new Center(child: new CircularProgressIndicator());
                    }))
          ],
        ),
      ),
    );
  }
}
