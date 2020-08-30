
class Networks {

  String name;
  int id;
  String logo_path;
  String origin_country;

	Networks.fromJsonMap(Map<String, dynamic> map): 
		name = map["name"],
		id = map["id"],
		logo_path = map["logo_path"],
		origin_country = map["origin_country"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = name;
		data['id'] = id;
		data['logo_path'] = logo_path;
		data['origin_country'] = origin_country;
		return data;
	}
}
