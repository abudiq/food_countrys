class modelFood{
  int id;
  String name;
  String title;
  String url;
  modelFood({this.id,this.name,this.title,this.url});

  Map<String,dynamic> toMap(){
    final map = Map<String,dynamic>();
    if(id != null){
      map['id'] = id;
    }
    map['name'] = name;
    map['title'] = title;
    map['url'] =url;
    return map;
}
factory modelFood.fromMap(Map<String , dynamic> map){
    return modelFood(id: map['id'],name: map['name'],title: map['title'],url:map['title']);
}



}