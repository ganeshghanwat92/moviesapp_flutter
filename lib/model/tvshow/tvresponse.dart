import 'package:movies_app/model/tvshow/tvresults.dart';

class TVResponse {

  int page;
  List<TVResults> results;
  int total_results;
  int total_pages;

	TVResponse.fromJsonMap(Map<String, dynamic> map):
		page = map["page"],
		results = List<TVResults>.from(map["results"].map((it) => TVResults.fromJsonMap(it))),
		total_results = map["total_results"],
		total_pages = map["total_pages"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['page'] = page;
		data['results'] = results != null ? 
			this.results.map((v) => v.toJson()).toList()
			: null;
		data['total_results'] = total_results;
		data['total_pages'] = total_pages;
		return data;
	}
}
