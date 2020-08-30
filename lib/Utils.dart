class Utils{

  static List<String> poster_sizes = [
  "w92",
  "w154",
  "w185",
  "w342",
  "w500",
  "w780",
  "original"
  ];

 static List<String> backdrop_sizes = [
  "w300",
  "w780",
  "w1280",
  "original"
  ];

  static String buildBackdropImageUrl(String path){

    if(path == null)
      path = "";

     const String baseUrl = "https://image.tmdb.org/t/p";
     const String size = "/original";

     return baseUrl+size+path;

  }

  static String buildPosterImageUrl(String path){

    if(path == null)
      path = "";

    const String baseUrl = "https://image.tmdb.org/t/p";
    const String size = "/w780";

    return baseUrl+size+path;

  }
}