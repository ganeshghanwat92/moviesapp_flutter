
class Seasons {

  String air_date;
  int episode_count;
  int id;
  String name;
  String overview;
  String poster_path;
  int season_number;

	Seasons.fromJsonMap(Map<String, dynamic> map): 
		air_date = map["air_date"],
		episode_count = map["episode_count"],
		id = map["id"],
		name = map["name"],
		overview = map["overview"],
		poster_path = map["poster_path"],
		season_number = map["season_number"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['air_date'] = air_date;
		data['episode_count'] = episode_count;
		data['id'] = id;
		data['name'] = name;
		data['overview'] = overview;
		data['poster_path'] = poster_path;
		data['season_number'] = season_number;
		return data;
	}
}
