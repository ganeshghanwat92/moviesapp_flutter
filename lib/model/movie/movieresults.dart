
class MovieResults {

  String poster_path;
  bool adult;
  String overview;
  String release_date;
  List<int> genre_ids;
  int id;
  String original_title;
  String original_language;
  String title;
  String backdrop_path;
  var popularity;
  var vote_count;
  bool video;
  var vote_average;

	MovieResults.fromJsonMap(Map<String, dynamic> map):
		poster_path = map["poster_path"],
		adult = map["adult"],
		overview = map["overview"],
		release_date = map["release_date"],
		genre_ids = List<int>.from(map["genre_ids"]),
		id = map["id"],
		original_title = map["original_title"],
		original_language = map["original_language"],
		title = map["title"],
		backdrop_path = map["backdrop_path"],
		popularity = map["popularity"],
		vote_count = map["vote_count"],
		video = map["video"],
		vote_average = map["vote_average"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['poster_path'] = poster_path;
		data['adult'] = adult;
		data['overview'] = overview;
		data['release_date'] = release_date;
		data['genre_ids'] = genre_ids;
		data['id'] = id;
		data['original_title'] = original_title;
		data['original_language'] = original_language;
		data['title'] = title;
		data['backdrop_path'] = backdrop_path;
		data['popularity'] = popularity;
		data['vote_count'] = vote_count;
		data['video'] = video;
		data['vote_average'] = vote_average;
		return data;
	}
}
