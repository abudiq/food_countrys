


class ModelCountry{
String url;
String tilte;
int id;
ModelCountry({this.tilte,this.url,this.id});
Map<String , dynamic> toMap(){
  final map = Map<String , dynamic>();
  if(id != null){
    map['id'] = id;
  }
  map['title'] = tilte;
  map ['url'] = url;
  return map;
}
factory ModelCountry.fromMap(Map<String , dynamic> map){
  return ModelCountry(id: map['id'],tilte: map['title'],url: map['url']);
}
}