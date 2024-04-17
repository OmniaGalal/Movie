import 'package:flutter/material.dart';
import 'package:moviesapp/api/api_manager.dart';
import 'package:moviesapp/models/Popular.dart';
import 'package:moviesapp/shared/colors.dart';

class SearchScreen extends StatelessWidget {
  //SearchScreen({Key? key}) : super(key: key);
  TextEditingController textController = TextEditingController();
  String base = "https://image.tmdb.org/t/p/w500/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: AppColors.greycolor,
                ),
                child: TextField(
                  controller: textController,
                  style: TextStyle(color: AppColors.whitecolor),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(35)),
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            FutureBuilder<Popular?>(
              future: ApiManager.getSearch(textController.text),
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
                  print("search${textController}");
                  return Expanded(
                    child: ListView.builder(
                       itemCount: snapshot.data!.results!.length,
                      itemBuilder: (context, index) {
                        // var list=snapshot.data![index];
                        return Column(
                          children: [
                            ListTile(
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
                            ),
                            Divider(thickness: 2,)
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
            // FutureBuilder<Popular?>(future: ApiManager.searchMovies(textController.text),
            //   builder: (context, snapshot) {
            //   if(snapshot.hasData){
            //     ListView.builder(
            //       //itemCount: snapshot.data!.length,
            //         itemBuilder: (context, index) => Column(children: [
            //
            //       ListTile(
            //         leading: Image.network(base+"${snapshot.data!.results![index].posterPath}"),
            //
            //         title: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text("${snapshot.data!.results![index].title}",style: TextStyle(color: Colors.white),),
            //             Text("omnia",style: TextStyle(color: Colors.white),),
            //             Text("${snapshot.data!.results![index].voteCount}",style: TextStyle(color: Colors.white),),
            //           ],
            //         ),
            //       ),
            //       Divider(
            //         thickness: 1,
            //       ),
            //     ],));
            //   }
            //   if(snapshot.hasError){
            //     return Text("Error");
            //   }
            //   return Center(child: CircularProgressIndicator());
            // },)
          ],
        ),
      ),
    );
  }
}
