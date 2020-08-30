import 'package:movies_app/model/tvshow/created_by.dart';
import 'package:movies_app/model/tvshow/genres.dart';
import 'package:movies_app/model/tvshow/last_episode_to_air.dart';
import 'package:movies_app/model/tvshow/networks.dart';
import 'package:movies_app/model/tvshow/production_companies.dart';
import 'package:movies_app/model/tvshow/seasons.dart';

class TvShowDetails {

  String backdrop_path;
  List<Created_by> created_by;
  List<int> episode_run_time;
  String first_air_date;
  List<Genres> genres;
  String homepage;
  int id;
  bool in_production;
  List<String> languages;
  String last_air_date;
  Last_episode_to_air last_episode_to_air;
  String name;
  Object next_episode_to_air;
  List<Networks> networks;
  int number_of_episodes;
  int number_of_seasons;
  List<String> origin_country;
  String original_language;
  String original_name;
  String overview;
  double popularity;
  String poster_path;
  List<Production_companies> production_companies;
  List<Seasons> seasons;
  String status;
  String type;
  double vote_average;
  int vote_count;

	TvShowDetails.fromJsonMap(Map<String, dynamic> map): 
		backdrop_path = map["backdrop_path"],
		created_by = List<Created_by>.from(map["created_by"].map((it) => Created_by.fromJsonMap(it))),
		episode_run_time = List<int>.from(map["episode_run_time"]),
		first_air_date = map["first_air_date"],
		genres = List<Genres>.from(map["genres"].map((it) => Genres.fromJsonMap(it))),
		homepage = map["homepage"],
		id = map["id"],
		in_production = map["in_production"],
		languages = List<String>.from(map["languages"]),
		last_air_date = map["last_air_date"],
		last_episode_to_air = Last_episode_to_air.fromJsonMap(map["last_episode_to_air"]),
		name = map["name"],
		next_episode_to_air = map["next_episode_to_air"],
		networks = List<Networks>.from(map["networks"].map((it) => Networks.fromJsonMap(it))),
		number_of_episodes = map["number_of_episodes"],
		number_of_seasons = map["number_of_seasons"],
		origin_country = List<String>.from(map["origin_country"]),
		original_language = map["original_language"],
		original_name = map["original_name"],
		overview = map["overview"],
		popularity = map["popularity"],
		poster_path = map["poster_path"],
		production_companies = List<Production_companies>.from(map["production_companies"].map((it) => Production_companies.fromJsonMap(it))),
		seasons = List<Seasons>.from(map["seasons"].map((it) => Seasons.fromJsonMap(it))),
		status = map["status"],
		type = map["type"],
		vote_average = map["vote_average"],
		vote_count = map["vote_count"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['backdrop_path'] = backdrop_path;
		data['created_by'] = created_by != null ? 
			this.created_by.map((v) => v.toJson()).toList()
			: null;
		data['episode_run_time'] = episode_run_time;
		data['first_air_date'] = first_air_date;
		data['genres'] = genres != null ? 
			this.genres.map((v) => v.toJson()).toList()
			: null;
		data['homepage'] = homepage;
		data['id'] = id;
		data['in_production'] = in_production;
		data['languages'] = languages;
		data['last_air_date'] = last_air_date;
		data['last_episode_to_air'] = last_episode_to_air == null ? null : last_episode_to_air.toJson();
		data['name'] = name;
		data['next_episode_to_air'] = next_episode_to_air;
		data['networks'] = networks != null ? 
			this.networks.map((v) => v.toJson()).toList()
			: null;
		data['number_of_episodes'] = number_of_episodes;
		data['number_of_seasons'] = number_of_seasons;
		data['origin_country'] = origin_country;
		data['original_language'] = original_language;
		data['original_name'] = original_name;
		data['overview'] = overview;
		data['popularity'] = popularity;
		data['poster_path'] = poster_path;
		data['production_companies'] = production_companies != null ? 
			this.production_companies.map((v) => v.toJson()).toList()
			: null;
		data['seasons'] = seasons != null ? 
			this.seasons.map((v) => v.toJson()).toList()
			: null;
		data['status'] = status;
		data['type'] = type;
		data['vote_average'] = vote_average;
		data['vote_count'] = vote_count;
		return data;
	}
}
