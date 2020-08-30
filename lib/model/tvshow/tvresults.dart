
class TVResults {

  String poster_path;
  double popularity;
  int id;
  String backdrop_path;
  var vote_average;
  String overview;
  String first_air_date;
  List<String> origin_country;
  List<int> genre_ids;
  String original_language;
  int vote_count;
  String name;
  String original_name;

	TVResults.fromJsonMap(Map<String, dynamic> map):
		poster_path = map["poster_path"],
		popularity = map["popularity"],
		id = map["id"],
		backdrop_path = map["backdrop_path"],
		vote_average = map["vote_average"],
		overview = map["overview"],
		first_air_date = map["first_air_date"],
		origin_country = List<String>.from(map["origin_country"]),
		genre_ids = List<int>.from(map["genre_ids"]),
		original_language = map["original_language"],
		vote_count = map["vote_count"],
		name = map["name"],
		original_name = map["original_name"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['poster_path'] = poster_path;
		data['popularity'] = popularity;
		data['id'] = id;
		data['backdrop_path'] = backdrop_path;
		data['vote_average'] = vote_average;
		data['overview'] = overview;
		data['first_air_date'] = first_air_date;
		data['origin_country'] = origin_country;
		data['genre_ids'] = genre_ids;
		data['original_language'] = original_language;
		data['vote_count'] = vote_count;
		data['name'] = name;
		data['original_name'] = original_name;
		return data;
	}
}
