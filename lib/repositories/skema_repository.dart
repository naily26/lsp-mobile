import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:my_final/models/skema.dart';

class HttpService {
  final String apiKey = 'd148de4964bd48400d8126d129b76224';
  final String baseUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=';
  final String newa = 'https://lsp-api.000webhostapp.com/api/get_kompetensi';

  Future<List?> getPopularMovies() async {
    final String uri = newa;

    http.Response result = await http.get(Uri.parse(uri));
    if(result.statusCode == HttpStatus.ok) {
      print("Sukses");
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['result'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      print("Fail");
      return null;
    }
  }
}