
class Last_episode_to_air {

  String air_date;
  int episode_number;
  int id;
  String name;
  String overview;
  String production_code;
  int season_number;
  int show_id;
  String still_path;
  double vote_average;
  int vote_count;

	Last_episode_to_air.fromJsonMap(Map<String, dynamic> map): 
		air_date = map["air_date"],
		episode_number = map["episode_number"],
		id = map["id"],
		name = map["name"],
		overview = map["overview"],
		production_code = map["production_code"],
		season_number = map["season_number"],
		show_id = map["show_id"],
		still_path = map["still_path"],
		vote_average = map["vote_average"],
		vote_count = map["vote_count"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['air_date'] = air_date;
		data['episode_number'] = episode_number;
		data['id'] = id;
		data['name'] = name;
		data['overview'] = overview;
		data['production_code'] = production_code;
		data['season_number'] = season_number;
		data['show_id'] = show_id;
		data['still_path'] = still_path;
		data['vote_average'] = vote_average;
		data['vote_count'] = vote_count;
		return data;
	}
}
