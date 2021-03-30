import 'package:flutter/material.dart';
import 'package:flutter_app25/database_helper.dart';
import 'package:flutter_app25/model.dart';
import 'package:flutter_app25/page_food.dart';

class Home extends StatefulWidget{
  HomeState createState() => HomeState();
}
class HomeState extends State<Home>{
  CountryDateBaseHelper dblite;
  Future<List<ModelCountry>> countrys;
  var dbhelper;
  @override
  void initState(){
    //CountryDateBaseHelper.instance.initDb();
    _updatelist();

  }
  _updatelist(){
    setState(() {
      countrys =  CountryDateBaseHelper.instance.getcountryList();
    });

  }
  Widget _buildCountry (ModelCountry country){
    return ListTile(
      title: Text(country.tilte),
      leading: Image.network(country.url),
      subtitle: Text("${country.id}"),
    );
  }
  GridView gridView(List<ModelCountry> snapshot) {
    return GridView.builder(
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: snapshot.length,
        padding: EdgeInsets.all(2),
        itemBuilder: (BuildContext context , int index){
          return _title(snapshot[index].id,snapshot[index].tilte,snapshot[index].url);
        },

      );

  }
  GridTile _title(int id , String title , String url){
    return GridTile(
        child: InkWell(
          onTap:() {
            Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) => PageFood(title: title,)


            ));
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadowColor: Colors.indigo,
              color: Colors.white,
              child: Padding(padding: EdgeInsets.all(10),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                      child: Hero(
                        tag: title,
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/nophoto.jpg",
                            image: url,
                        width: 130,
                          height: 120,
                        ),

                      ),
                ),

                    ),
                    Text(title,style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600),),

                  ],
                ),
              ),
              ),

            ),
          ),
        ),

    );
  }



  Widget build(context){
  return Scaffold(
    appBar: new AppBar(
      centerTitle: true,
      title: Text("Food Country"),
      leadingWidth: 30,
      backgroundColor: Colors.redAccent,

    ),
    body: Padding(
      padding: EdgeInsets.all(20),
      child: FutureBuilder(
        future: countrys,
        builder: (BuildContext context , AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          return gridView(snapshot.data);


        },
      ),
    )

    ,
  );



  }
}