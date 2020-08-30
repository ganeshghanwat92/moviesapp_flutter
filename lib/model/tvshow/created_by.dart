
class Created_by {

  int id;
  String credit_id;
  String name;
  int gender;
  String profile_path;

	Created_by.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		credit_id = map["credit_id"],
		name = map["name"],
		gender = map["gender"],
		profile_path = map["profile_path"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['credit_id'] = credit_id;
		data['name'] = name;
		data['gender'] = gender;
		data['profile_path'] = profile_path;
		return data;
	}
}
