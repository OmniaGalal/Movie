import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moviesapp/api/api_manager.dart';
import 'package:moviesapp/models/recommended.dart';
import 'package:moviesapp/models/upcoming.dart';
import 'package:moviesapp/shared/colors.dart';

import '../../models/Popular.dart';

class MovieScreen extends StatefulWidget {
  MovieScreen({Key? key}) : super(key: key);
  static const String routeName = "movie";

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  String base = "https://image.tmdb.org/t/p/w500/";
  int selectedIndex = 0;
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: isVisible
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 3,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  isVisible = false;
                                  setState(() {});
                                  // Navigator.pushNamed(context, MovieScreen.routeName,arguments: detailsArgs(selectedIndex, base));
                                  print("index::$selectedIndex");
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    FutureBuilder<Popular?>(
                                      future: ApiManager.getPopular(),
                                      builder: (context, snapshot) {

                                        return CarouselSlider.builder(
                                          options: CarouselOptions(
                                            height: 200,
                                            aspectRatio: .05,
                                            viewportFraction: 1,
                                            initialPage: 0,
                                            enableInfiniteScroll: true,
                                            reverse: false,
                                            autoPlay: true,
                                            autoPlayInterval:
                                                Duration(seconds: 3),
                                            autoPlayAnimationDuration:
                                                Duration(milliseconds: 800),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enlargeCenterPage: true,
                                            enlargeFactor: 0.3,
                                            onPageChanged: (index, reason) {
                                              selectedIndex = index;
                                              print(selectedIndex);
                                              setState(() {});
                                            },
                                            scrollDirection: Axis.horizontal,
                                          ),
                                          itemCount:
                                              snapshot.data!.results!.length,
                                          itemBuilder: (BuildContext context,
                                                  int itemIndex,
                                                  int pageViewIndex) =>
                                              Container(
                                            child: Image.network(
                                              base +
                                                  '${snapshot.data!.results![itemIndex].posterPath}',
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // print("index::$selectedIndex");
                                      },
                                      icon: Icon(
                                        Icons.play_circle,
                                        size: 70,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 16.0, bottom: 15, top: 8),
                                child: FutureBuilder<Popular?>(
                                  future: ApiManager.getPopular(),
                                  builder: (context, snapshot) => Text(
                                    "${snapshot.data!.results![selectedIndex].title}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: FutureBuilder<Popular?>(
                                  future: ApiManager.getPopular(),
                                  builder: (context, snapshot) => Text(
                                    "${snapshot.data!.results![selectedIndex].releaseDate}",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 170,
                            height: 300,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 70),
                              child: FutureBuilder<Popular?>(
                                future: ApiManager.getPopular(),
                                builder: (context, snapshot) => Image.network(
                                  base +
                                      "${snapshot.data!.results![selectedIndex].posterPath}",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        color: AppColors.greycolor,
                        child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: FutureBuilder<Upcoming?>(
                              future: ApiManager.getUpcoming(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  // print(snapshot);
                                  var list = snapshot.data!;
                                  print('ooo');
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(base +
                                            '${list.results![index].posterPath}'),
                                      );
                                    },
                                    itemCount: list.results!.length,
                                  );
                                }
                                if (snapshot.hasError) {
                                  return Text("ERROR");
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ))),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        color: AppColors.greycolor,
                        child: FutureBuilder<Recommended?>(
                          future: ApiManager.getRecommended(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              // print(snapshot);
                              var list = snapshot.data!;
                              print('ooo');
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        color: AppColors.gcolor,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              base +
                                                  '${list.results![index].posterPath}',
                                              fit: BoxFit.cover,
                                              width: 100,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: AppColors.yellowcolor,
                                                  size: 18,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  "${list.results![index].voteAverage}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "${list.results![index].title}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8),
                                            ),
                                            Text(
                                              "${list.results![index].releaseDate}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 8),
                                            )
                                          ],
                                        ),
                                      ));
                                },
                                itemCount: list.results!.length,
                              );
                            }
                            if (snapshot.hasError) {
                              return Text("ERROR");
                            }
                            return new Center(
                                child: new CircularProgressIndicator());
                          },
                        )),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<Popular?>(
                      future: ApiManager.getPopular(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Container(
                          child: Image.network(
                            base +
                                '${snapshot.data!.results![selectedIndex].posterPath}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * .3,
                          ),
                        );
                      }),
                  FutureBuilder<Popular?>(
                      future: ApiManager.getPopular(),
                      builder: (context, snapshot) {
                        return Text(
                          "${snapshot.data!.results![selectedIndex].title}",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: FutureBuilder<Popular?>(
                      future: ApiManager.getPopular(),
                      builder: (context, snapshot) => Text(
                        "${snapshot.data!.results![selectedIndex].releaseDate}",
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<Popular?>(
                          future: ApiManager.getPopular(),
                          builder: (context, snapshot) => Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Image.network(
                                base +
                                    '${snapshot.data!.results![selectedIndex].posterPath}',
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.height * .2,
                                height:
                                    MediaQuery.of(context).size.height * .23,
                              ),
                            ),
                          ),
                        ),
                        FutureBuilder<Popular?>(
                          future: ApiManager.getPopular(),
                          builder: (context, snapshot) => Container(
                              child: Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Text(
                                  "${snapshot.data!.results![selectedIndex].overview}",
                                  style: TextStyle(color: Colors.white),
                                  //overflow: TextOverflow.ellipsis,
                                  maxLines: MediaQuery.of(context)
                                      .size
                                      .width
                                      .ceil(), // Calculate maxLines dynamically
                                  softWrap: true,
                                ),
                              ),
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        color: AppColors.greycolor,
                        child: FutureBuilder<Popular?>(
                          future: ApiManager.getSimilar(selectedIndex + 1),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              // print(snapshot);
                              var list = snapshot.data!;
                              print('ooo');
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        color: AppColors.gcolor,
                                        child: Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.network(
                                                base +
                                                    '${list.results![selectedIndex].posterPath}',
                                                fit: BoxFit.cover,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .2,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color: AppColors
                                                              .yellowcolor,
                                                          size: 18,
                                                        ),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Text(
                                                          "${list.results![index].voteAverage}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "${list.results![index].title}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 8),
                                                    ),
                                                    Text(
                                                      "${list.results![index].releaseDate}",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 8),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                },
                                itemCount: list.results!.length,
                              );
                            }
                            if (snapshot.hasError) {
                              return Text("ERROR");
                            }
                            return new Center(
                                child: new CircularProgressIndicator());
                          },
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ));
  }
}
