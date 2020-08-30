
import 'package:movies_app/model/multisearch/known_for.dart';

class Results {

  String original_name;
  List<int> genre_ids;
  String media_type;
  String name;
  var popularity;
  List<String> origin_country;
  List<KnownFor> known_for;
  int vote_count;
  String first_air_date;
  String backdrop_path;
  String original_language;
  int id;
  var vote_average;
  String overview;
  String poster_path;
  String profile_path;
  String known_for_department;
  String title;

  Results();

	Results.fromJsonMap(Map<String, dynamic> map): 
		original_name = map["original_name"],
		genre_ids =map["genre_ids"] == null ? null : List<int>.from(map["genre_ids"]),
		media_type = map["media_type"],
		name = map["name"],
		popularity = map["popularity"],
		origin_country = map["origin_country"] == null ? null : List<String>.from(map["origin_country"]),
		known_for = map["known_for"] == null ? null : List<KnownFor>.from(map["known_for"].map((it) => KnownFor.fromJsonMap(it))),
	  vote_count = map["vote_count"],
		first_air_date = map["first_air_date"],
		backdrop_path = map["backdrop_path"],
		original_language = map["original_language"],
		id = map["id"],
		vote_average = map["vote_average"],
		overview = map["overview"],
		poster_path = map["poster_path"],
	  profile_path = map["profile_path"],
	 known_for_department = map["known_for_department"],
	 title = map["title"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['original_name'] = original_name;
		data['genre_ids'] = genre_ids;
		data['media_type'] = media_type;
		data['name'] = name;
		data['popularity'] = popularity;
		data['origin_country'] = origin_country;
		data['known_for'] = known_for;
		data['vote_count'] = vote_count;
		data['first_air_date'] = first_air_date;
		data['backdrop_path'] = backdrop_path;
		data['original_language'] = original_language;
		data['id'] = id;
		data['vote_average'] = vote_average;
		data['overview'] = overview;
		data['poster_path'] = poster_path;
		data['profile_path'] = profile_path;
		data['known_for_department'] = known_for_department;
		data['title'] = title;
		return data;
	}
}
