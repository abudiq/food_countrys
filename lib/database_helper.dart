import 'package:flutter/services.dart';
import 'package:flutter_app25/model.dart';
import 'package:flutter_app25/modelfood.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class CountryDateBaseHelper{
  String tablename = "Countries";
  static final CountryDateBaseHelper instance = CountryDateBaseHelper._instance();
  CountryDateBaseHelper._instance();
  Database _db;
  Future<Database> get db async{
    if(_db == null){
      print("the db is create");
      _db = await initDb();
    }
    return _db;
  }
  Future initDb() async{
    final dbpath = await getDatabasesPath();
    final path = join(dbpath,'country.db');
    final exist = await databaseExists(path);
    if(exist){
      print("db already exsits");
      await openDatabase(path);
    }else{
      print("creating a copy frome assets");
      try{
        await Directory(dirname(path)).create(recursive: true);
      }catch(_){}
      ByteData data = await rootBundle.load(join("assets","country.db"));
      List<int> bytes = await data.buffer.asInt8List(
        data.offsetInBytes , data.lengthInBytes
      );
      await File(path).writeAsBytes(bytes,flush: true);
      print("db coped");
    }
    return await openDatabase(path);
  }
  Future<List<Map<String , dynamic>>> getcountryMapList() async{
    Database db = await this.db;
    final List<Map<String , dynamic>> result = await db.query(tablename);
    return result;
  }
  Future<List<ModelCountry>> getcountryList() async{
    final List<Map<String ,dynamic>> countrymaplist = await getcountryMapList();
    final List<ModelCountry> modelCountrylist = [];
    countrymaplist.forEach((countrymap) {
      modelCountrylist.add(ModelCountry.fromMap(countrymap));
    });
    return modelCountrylist;
 }
  Future<List<Map<String , dynamic>>> getfoodMapList(String tablename) async{
    Database db = await this.db;
    final List<Map<String , dynamic>> result = await db.query(tablename);
    return result;
  }

  Future<List<modelFood>> getfoodList(String nametable) async{
    final List<Map<String ,dynamic>> countrymaplist = await getfoodMapList(nametable);
    final List<modelFood> modelCountrylist = [];
    countrymaplist.forEach((countrymap) {
      modelCountrylist.add(modelFood.fromMap(countrymap));
    });
    return modelCountrylist;
  }
  Future<List<Map<String , dynamic>>> getserchfoodMapList(String tablename , String search) async{
    Database db = await this.db;
    //final List<Map<String , dynamic>> result = await db.query(tablename,where: " name = ?" ,whereArgs: [search]);
    final List<Map<String , dynamic>> result = await db.rawQuery(' SELECT * FROM "$tablename" WHERE "name" LIKE "%$search%" ');
    //db.rawQuery('SELECT * FROM "table"')
    //final List<Map<String , dynamic>> result = await db.execute("SELECT * FROM table WHERE value1 LIKE '%O%' OR value2 LIKE '%1%'");

    return result;
  }

  Future<List<modelFood>> getserachfoodList(String nametable , String search) async{
    final List<Map<String ,dynamic>> countrymaplist = await getserchfoodMapList(nametable,search);
    final List<modelFood> modelCountrylist = [];
    countrymaplist.forEach((countrymap) {
      modelCountrylist.add(modelFood.fromMap(countrymap));
    });
    return modelCountrylist;
  }
}