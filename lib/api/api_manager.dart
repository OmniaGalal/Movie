import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviesapp/api/api_constants.dart';
import 'package:moviesapp/models/Popular.dart';
import 'package:moviesapp/models/browse.dart';
import 'package:moviesapp/models/filtered.dart';
import 'package:moviesapp/models/recommended.dart';
import 'package:moviesapp/models/upcoming.dart';

class ApiManager {
  ///https://api.themoviedb.org/3/movie/popular
  // static Future<Popular?> getPopular() async {
  //   try {
  //     // Uri url = Uri.http(ApiConstants.baseUrl, ApiConstants.Source,
  //     //     );
  //     // var response = await http.get(url);
  //     // var responseBody = response.body;
  //     //var json = jsonDecode(responseBody);
  //     final response = await http
  //         .get(Uri.parse('https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1'));
  //     if (response.statusCode == 200) {
  //       print('success');
  //       return Popular.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  //     } else {
  //
  //       throw Exception('Failed to load album');
  //     }
  //    // return Popular.fromJson(json);
  //
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  static Future<Upcoming?> getUpcoming() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1&api_key=${ApiConstants.apiKey}'));

      if (response.statusCode == 200) {
        print('success');
        return Upcoming.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load popular movies');
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<Recommended?> getRecommended() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1&api_key=${ApiConstants.apiKey}'));

      if (response.statusCode == 200) {
        print('success');
        return Recommended.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load Recommended movies');
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<Popular?> getPopular() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&api_key=${ApiConstants.apiKey}'));

      if (response.statusCode == 200) {
        print('success');
        return Popular.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load Recommended movies');
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<Popular?> getDetails() async {
    try {
      final response = await http.get(Uri.parse(
          'https:https://api.themoviedb.org/3/movie/7?api_key=${ApiConstants.apiKey}'));

      if (response.statusCode == 200) {
        print('success');
        return Popular.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load Recommended movies');
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<Popular?> getSimilar(int id) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/${id}/similar?api_key=${ApiConstants.apiKey}'));

      if (response.statusCode == 200) {
        print('success');
        return Popular.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load Recommended movies');
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<Browse?> fetchGenres() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/genre/movie/list?language=en&api_key=bc1108132e9cb20e4189f1284db90930'));

      if (response.statusCode == 200) {
        return Browse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load genres');
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<Browse?> listMovies(int id) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/genre/movie/${id}/list?language=en&api_key=bc1108132e9cb20e4189f1284db90930'));

      if (response.statusCode == 200) {
        return Browse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load genres');
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<Filtered?> filteredmovies(int id) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&with_genres=$id&sort_by=popularity.desc&api_key=bc1108132e9cb20e4189f1284db90930'));

      if (response.statusCode == 200) {
        return Filtered.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load genres');
      }
    } catch (e) {
      throw e;
    }
  }
  // static Future<Browse?> getCategorey() async {
  //   try {
  //
  //     final response = await http.get(Uri.parse(
  //         'https://api.themoviedb.org/3/genre/movie/list?language=en?api_key=${ApiConstants.apiKey}'));
  //
  //     if (response.statusCode == 200) {
  //       print('success');
  //       return Browse.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  //     } else {
  //       throw Exception('Failed to load Recommended movies');
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // static Future<Popular> searchMovies(String query) async {
  //   try {
  //     final response = await http.get(Uri.parse(
  //         'https://api.themoviedb.org/3/search/movie?api_key=${ApiConstants.apiKey}&language=en-US&page=1&query=$query&include_adult=false'));
  //
  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = jsonDecode(response.body)['results'];
  //       List<Popular> searchResults = data.map((json) => Popular.fromJson(json)).toList();
  //       return searchResults;
  //     } else {
  //       throw Exception('Failed to search movies');
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }
  static Future<Popular?> getSearch(String text) async {
    try {
      final response = await http.get(Uri.parse(


      'https://api.themoviedb.org/3/search/movie?include_adult=false&language=en-US&page=1&query=$text&api_key=bc1108132e9cb20e4189f1284db90930'));
//
      if (response.statusCode == 200) {
        print('success');
        return Popular.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load Recommended movies');
      }
    } catch (e) {
      throw e;
    }
  }
}
