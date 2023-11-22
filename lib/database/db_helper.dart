import 'dart:io';

import 'package:children_name/model/name_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const dbName = "children_name_db.db";
  static const dbVersion = 1;
  static const maleNameTable = "male_name";
  static const femaleNameTable = "female_name";
  static const krishnaNameTable = "krishna_name";
  static const colId = "id";
  static const colName = "name";
  static const colNameEn = "name_en";
  static const colMeaning = "meaning";
  static const colFavorite = "favorite";

  //Constructor
  DBHelper._privateConstructor();

  static DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await initDb();

  Future<Database> initDb() async {
    var databasePath = await getApplicationDocumentsDirectory();
    String path = join(databasePath.path, dbName);

    //check existing
    var exists = await databaseExists(path);

    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //
    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    // String version = packageInfo.version;
    // String buildNumber = packageInfo.buildNumber;
    // debugPrint("Current Version: " + version);

    // var val = getStringValuesSF();
    // if (val.toString().isEmpty) {
    //   debugPrint("new_version_stored: " + val.toString());
    //   addStringToSF(version);
    // }
    // if (val.toString().isNotEmpty) {
      if (!exists) {
        //if not exists
        debugPrint("Start copy database from assets");
        try {
          await Directory(dirname(path)).create(recursive: true);
        } catch (_) {}

        //copy
        ByteData data = await rootBundle.load(join("assets/csv_data", dbName));
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        //write
        await File(path).writeAsBytes(bytes, flush: true);
      } else {
        debugPrint("Opening existing database");
      }
    // }

    return await openDatabase(path, version: dbVersion);
  }

  // void addStringToSF(String version) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('version', version);
  // }
  //
  // Future<String?> getStringValuesSF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? stringValue = prefs.getString('version');
  //   return stringValue;
  // }

  //=========================
  //Read Krishna Names
  //=========================
  //get the Map list and convert it to Note List
  Future<List<NameModel>> getKrishnaNameList() async {
    Database? db = await instance.database;
    var noteMapList = await db.query(krishnaNameTable);

    List<NameModel> noteList = [];
    for (int i = 0; i < noteMapList.length; i++) {
      noteList.add(NameModel.fromMap(noteMapList[i]));
    }
    return noteList;
  }

  //=========================
  //Read Male Names
  //=========================
  //get the Map list and convert it to Note List
  Future<List<NameModel>> getMaleNameList() async {
    Database? db = await instance.database;
    var noteMapList = await db.query(maleNameTable);

    List<NameModel> noteList = [];
    for (int i = 0; i < noteMapList.length; i++) {
      noteList.add(NameModel.fromMap(noteMapList[i]));
    }
    return noteList;
  }

  Future<List<NameModel>> getFavMaleNameList() async {
    Database? db = await instance.database;
    var noteMapList = await db
        .query(maleNameTable, where: colFavorite + " = ?", whereArgs: [1]);

    List<NameModel> noteList = [];
    for (int i = 0; i < noteMapList.length; i++) {
      noteList.add(NameModel.fromMap(noteMapList[i]));
    }
    return noteList;
  }

  //=========================
  //Read Female Names
  //=========================
  //get the Map list and convert it to Note List
  Future<List<NameModel>> getFemaleNameList() async {
    Database? db = await instance.database;
    var noteMapList = await db.query(femaleNameTable);

    List<NameModel> noteList = [];
    for (int i = 0; i < noteMapList.length; i++) {
      noteList.add(NameModel.fromMap(noteMapList[i]));
    }
    return noteList;
  }

  Future<List<NameModel>> getFavFemaleNameList() async {
    Database? db = await instance.database;
    var noteMapList = await db
        .query(femaleNameTable, where: colFavorite + " = ?", whereArgs: [1]);

    List<NameModel> noteList = [];
    for (int i = 0; i < noteMapList.length; i++) {
      noteList.add(NameModel.fromMap(noteMapList[i]));
    }
    return noteList;
  }

  //update male name
  Future<int> updateMaleName(NameModel item) async {
    Database db = await instance.database;

    var result = await db.update(maleNameTable, item.toMap(),
        where: "id = ?", whereArgs: [item.id]);
    return result;
  }

  //update female name
  Future<int> updateFemaleName(NameModel item) async {
    Database db = await instance.database;

    var result = await db.update(femaleNameTable, item.toMap(),
        where: "id = ?", whereArgs: [item.id]);
    return result;
  }
}
