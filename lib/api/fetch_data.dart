import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:movies_app/api/models/actor_model.dart';
import 'package:movies_app/api/models/movieModel.dart';

Future<List<MovieModel>> fetchTrendingDay() async {
  int randomNumber = new Random().nextInt(6); //
  http.Response response;
  if (randomNumber != 0) {
    response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/trending/movie/week?page=${randomNumber.toString()}&api_key=a78a8bf243fae3d26b50151c98fd6a43'),
    );
  } else {
    response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/trending/movie/week?page=3&api_key=a78a8bf243fae3d26b50151c98fd6a43'),
    );
  }
  var body = jsonDecode(response.body);

  List<MovieModel> movies = [];
  if (response.statusCode == 200) {
    for (var movie in body['results']) {
      if (movie['backdrop_path'] != null) {
        movies.add(MovieModel.fromJson(movie));
      }
    }
    movies.shuffle();
    movies.shuffle();
    return movies;
  } else {
    print(response.statusCode);
  }
  return null;
}

Future<List<MovieModel>> fetchTrendingWeak([page = 0]) async {
  int randomNumber = new Random().nextInt(11); //

  List<MovieModel> moviesNew = [];
  http.Response response;
  if (page != 0) {
    response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/trending/movie/week?page=$page&adult=false&api_key=a78a8bf243fae3d26b50151c98fd6a43'),
    );
  } else {
    if (randomNumber != 0) {
      response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/trending/movie/week?page=${randomNumber.toString()}&adult=false&api_key=a78a8bf243fae3d26b50151c98fd6a43'),
      );
    } else {
      response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/trending/movie/week?page=5&adult=false&api_key=a78a8bf243fae3d26b50151c98fd6a43'),
      );
    }
  }

  var body = jsonDecode(response.body);
  if (response.statusCode == 200) {
    for (var movie in body['results']) {
      moviesNew.add(MovieModel.fromJson(movie));
    }

    return moviesNew.toSet().toList();
  } else {
    print(response.statusCode);
  }
  return null;
}

Future<List<MovieModel>> fetchTopRated([page = 0]) async {
  int randomNumber = new Random().nextInt(5); //
  http.Response response;
  if (page != 0) {
    response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?page=$page&api_key=a78a8bf243fae3d26b50151c98fd6a43&language=en-US'),
    );
  } else {
    if (randomNumber != 0) {
      response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/top_rated?page=${randomNumber.toString()}&api_key=a78a8bf243fae3d26b50151c98fd6a43&language=en-US'),
      );
    } else {
      response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/top_rated?page=3&api_key=a78a8bf243fae3d26b50151c98fd6a43&language=en-US'),
      );
    }
  }

  var body = jsonDecode(response.body);

  List<MovieModel> movies = [];
  if (response.statusCode == 200) {
    for (var movie in body['results']) {
      movies.add(MovieModel.fromJson(movie));
    }
    return movies;
  } else {
    print(response.statusCode);
  }
  return null;
}

Future<List<MovieModel>> fetchSimilarMovies(id) async {
  http.Response response = await http.get(
    Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/similar?api_key=a78a8bf243fae3d26b50151c98fd6a43&language=en-US&page=1'),
  );
  var body = jsonDecode(response.body);

  List<MovieModel> movies = [];
  if (response.statusCode == 200) {
    for (var movie in body['results']) {
      movies.add(MovieModel.fromJson(movie));
    }
    return movies;
  } else {
    print(response.statusCode);
  }
  return null;
}

Future<List<ActorModel>> fetchPopularPersons() async {
  http.Response response = await http.get(
    Uri.parse(
        'https://api.themoviedb.org/3/trending/person/week?api_key=a78a8bf243fae3d26b50151c98fd6a43'),
  );
  var body = jsonDecode(response.body);

  List<ActorModel> actors = [];
  if (response.statusCode == 200) {
    for (var actor in body['results']) {
      if (actor['profile_path'] != null) {
        actors.add(ActorModel.fromJson(actor));
      }
    }
    return actors;
  } else {
    print(response.statusCode);
  }
  return null;
}

var isLoading;
Future<List<MovieModel>> fetchTrendingWeakHasMore([page = 1]) async {
  isLoading = false;
  http.Response response = await http.get(
    Uri.parse(
        'https://api.themoviedb.org/3/trending/movie/week?page=$page&api_key=a78a8bf243fae3d26b50151c98fd6a43'),
  );
  var body = jsonDecode(response.body);

  List<MovieModel> movies = [];
  if (response.statusCode == 200) {
    for (var movie in body['results']) {
      movies.add(MovieModel.fromJson(movie.toSet().toList()));
    }
    isLoading = true;

    return movies.toSet().toList();
  } else {
    print(response.statusCode);
  }
  return null;
}
