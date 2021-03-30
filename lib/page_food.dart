import 'package:flutter/material.dart';
import 'package:flutter_app25/database_helper.dart';
import 'package:flutter_app25/modelfood.dart';
import 'package:flutter_app25/page_this_food.dart';

class PageFood extends StatefulWidget{
  String title;
  PageFood({this.title});
  StatePageFood createState() => StatePageFood();

}
class StatePageFood extends State<PageFood>{
  TextEditingController _textEditingController = TextEditingController();
  bool srechpool ;
  Future<List<modelFood>> listfood;
  void initState(){
    super.initState();
    _updataeList(widget.title);
    srechpool = false;
  }


  _updataeList(String nametable) {
    setState(() {
      listfood = CountryDateBaseHelper.instance.getfoodList(nametable);
    });
  }
    _updataeListwithserch(String nametable , String search) {
      setState(() {
        listfood =  CountryDateBaseHelper.instance.getserachfoodList(nametable , search);
      });

  }
  Widget build (context){
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        title: (!srechpool) ? Text(widget.title,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),) : TextField(decoration: InputDecoration(hintText: "serchhere",icon: Icon(Icons.search,color: Colors.white,),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),

        ),controller: _textEditingController,
          onChanged: (text){
          setState(() {
            _updataeListwithserch(widget.title, text.toLowerCase());

          });
          },
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,


        ),
        centerTitle: true,
        actions: [
          (!srechpool) ? IconButton(icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  srechpool = !srechpool;
                });
              },
            ) : IconButton(icon: Icon(Icons.cancel), onPressed: (){
              setState(() {
                srechpool = ! srechpool;
                _textEditingController.text = "";
                _updataeList(widget.title);
              });
          })
          ,
        ],

      ),
      body: Padding(padding: EdgeInsets.all(10),
      child: FutureBuilder(
        future: listfood,
        builder: (BuildContext context , AsyncSnapshot data){
          if(!data.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          return _listViewfood(data.data);
        },

      ),
      ),
    );
  }
  Widget _listViewfood(List<modelFood> snapshot){
    return ListView.builder(
        itemCount: snapshot.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (BuildContext context , int index){
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) => pageThisfood(name: snapshot[index].name,title:snapshot[index].title ,id:snapshot[index].id ,namecountry: widget.title,))
                );
              },
              child: cardfood(snapshot[index].name, snapshot[index].title, snapshot[index].url , snapshot[index].id),
            );
        }

    );

  }
  Card cardfood(String name , String title , String url , int id) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        shadowColor: Colors.indigoAccent,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: name,
                    child:   Image.asset(
                        "assets/${widget.title}/${id}.jpg"
                    )

            ),
          ),
                ),
                SizedBox(height: 10,),
                Text(name,style: TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text(title,style: TextStyle(fontSize: 16,color: Colors.black),)
              ],
            ),
          ),
        ),


      );

  }

}