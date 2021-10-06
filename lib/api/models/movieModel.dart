class MovieModel {
  String backdropPath;
  List<int> genreIds;
  String releaseDate;
  String originalLanguage;
  String originalTitle;
  String posterPath;
  bool video;
  double voteAverage;
  String title;
  int id;
  String overview;
  bool adult;
  String mediaType;

  MovieModel(
      {this.backdropPath,
      this.genreIds,
      this.releaseDate,
      this.originalLanguage,
      this.originalTitle,
      this.posterPath,
      this.video,
      this.voteAverage,
      this.title,
      this.id,
      this.overview,
      this.adult,
      this.mediaType});

  MovieModel.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    releaseDate = json['release_date'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    posterPath = json['poster_path'];
    video = json['video'];
    voteAverage = json['vote_average'];
    title = json['title'];
    id = json['id'];
    overview = json['overview'];
    adult = json['adult'];
    mediaType = json['media_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backdrop_path'] = this.backdropPath;
    data['genre_ids'] = this.genreIds;
    data['release_date'] = this.releaseDate;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['poster_path'] = this.posterPath;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['title'] = this.title;
    data['id'] = this.id;
    data['overview'] = this.overview;
    data['adult'] = this.adult;
    data['media_type'] = this.mediaType;
    return data;
  }
}
