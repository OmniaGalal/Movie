import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/models/filtered.dart';

import '../../api/api_manager.dart';

class FilteredMovies extends StatelessWidget {
  const FilteredMovies({Key? key}) : super(key: key);
  static const String routeName = "filtered";
  @override
  Widget build(BuildContext context) {
    var args=ModalRoute.of(context)!.settings.arguments as int ;
    return Scaffold(
      body: FutureBuilder<Filtered?>(
        future: ApiManager.filteredmovies(args),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError) {
            print("error");

            return Center(child: Text('Error: ${snapshot.error}'));
          }

          else if (snapshot.hasData) {
            print("hasdata");
            print("id${args}");
            return ListView.builder(
              // itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // var list=snapshot.data![index];
                return ListTile(
                  leading: SizedBox(
                    width: 80,
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${snapshot.data?.results![index!].posterPath}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text("${snapshot.data!.results![index!]!.title}",style: TextStyle(color: Colors.white),),
                  subtitle: Text("${snapshot.data?.results![index!].voteCount}",style: TextStyle(color: Colors.grey)),
                  onTap: () {
                    // Handle tapping on the movie card (e.g., navigate to movie details)
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),


    );
  }
}
class filtersArgs{
  int id;
  filtersArgs({required this.id});
}