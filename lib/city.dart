 class City {
   final String name ;
   City({this.name});

  static City fromJson(Map<String,dynamic> json){

    return City(name:json['name']);

  }
}