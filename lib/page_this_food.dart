
import 'package:flutter/material.dart';


class pageThisfood extends StatefulWidget {
  int id;
  String title;
  String name;
  String namecountry;
  pageThisfood({this.name,this.title,this.id,this.namecountry});
  StatepageThisfood createState() => StatepageThisfood();
}
class StatepageThisfood extends State<pageThisfood>{
  Widget build(context){
    return Scaffold(
      appBar: new AppBar(
        title: Text(widget.name),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 20,),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)
                  ),

                  child: Hero(tag: widget.name, child: Image.asset("assets/${widget.namecountry}/${widget.id}"+".jpg"),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(padding: EdgeInsets.all(5),
                  child: Text(widget.title,style: TextStyle(fontSize: 26 ,color: Colors.black,fontStyle: FontStyle.italic),)
                  ,
                )
              ],
            ),
          ),
        ),
      )
    );
  }
  
  
}