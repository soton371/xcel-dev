import 'dart:developer';
import 'dart:io';
import 'package:xcel_medical_center/model/water_reminder_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  factory DBProvider() => _instance;

  static final DBProvider _instance = DBProvider._();

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'data.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE WaterReminder('
          'id INTEGER PRIMARY KEY AUTOINCREMENT ,'
          'goal TEXT DEFAULT "0",'
          'waterDrunk TEXT DEFAULT "0",'
          'date TEXT'
          ')');
    });
  }

  // Insert value into "WaterReminder" table
  Future<List<WaterReminderData>> addToWaterReminderData(
      String goal, String waterDrunk, String date) async {
    final db = await database;
    final res = await db!.rawQuery(
        "INSERT INTO WaterReminder(goal, waterDrunk, date) VALUES(?, ?, ?)",
        [goal, waterDrunk, date]);

    List<WaterReminderData> list = res.isNotEmpty
        ? res.map((c) => WaterReminderData.fromMap(c)).toList()
        : [];
    return list;
  }

  //Get data from "WaterReminder" table
  Future<List<WaterReminderData>> getWaterReminderData() async {
    final db = await database;
    final res =
        await db?.rawQuery("SELECT * FROM WaterReminder ORDER BY id DESC");

    List<WaterReminderData> list = res!.isNotEmpty
        ? res.map((c) => WaterReminderData.fromMap(c)).toList()
        : [];
    return list;
  }

  //Get total waterDrunk "WaterReminder" table
  Future<String> getTotalWaterDrunk() async {
    final db = await database;
    final res = await db?.rawQuery(
        "SELECT SUM(waterDrunk) totalAmount FROM WaterReminder"); //totalAmount is the key where the value of sum will be set

    String totalWaterDrunk =
        (res??[])[0]['totalAmount'] == null ? '0.0' : (res??[])[0]['totalAmount'].toString();
    log(totalWaterDrunk);
    return totalWaterDrunk;
  }
}
