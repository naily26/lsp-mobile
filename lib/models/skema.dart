class Movie {
  int? id;
  String? nama_skema;
  double? voteAverage;
  String? overview;
  String? posterPath;

  Movie(this.id, this.nama_skema, this.voteAverage, this.overview, this.posterPath);

  Movie.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.nama_skema = parsedJson['nama_skema'];
    this.voteAverage = parsedJson['vote_average'] * 1.0;
    this.overview = parsedJson['overview'];
    this.posterPath = parsedJson['poster_path'];
  }
}