
class People {

  String birthday;
  String known_for_department;
  Object deathday;
  int id;
  String name;
  List<String> also_known_as;
  int gender;
  String biography;
  double popularity;
  String place_of_birth;
  String profile_path;
  bool adult;
  String imdb_id;
  String homepage;

	People.fromJsonMap(Map<String, dynamic> map): 
		birthday = map["birthday"],
		known_for_department = map["known_for_department"],
		deathday = map["deathday"],
		id = map["id"],
		name = map["name"],
		also_known_as = List<String>.from(map["also_known_as"]),
		gender = map["gender"],
		biography = map["biography"],
		popularity = map["popularity"],
		place_of_birth = map["place_of_birth"],
		profile_path = map["profile_path"],
		adult = map["adult"],
		imdb_id = map["imdb_id"],
		homepage = map["homepage"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['birthday'] = birthday;
		data['known_for_department'] = known_for_department;
		data['deathday'] = deathday;
		data['id'] = id;
		data['name'] = name;
		data['also_known_as'] = also_known_as;
		data['gender'] = gender;
		data['biography'] = biography;
		data['popularity'] = popularity;
		data['place_of_birth'] = place_of_birth;
		data['profile_path'] = profile_path;
		data['adult'] = adult;
		data['imdb_id'] = imdb_id;
		data['homepage'] = homepage;
		return data;
	}
}
