import 'package:home_work_second/Model/task.dart';
import 'package:sqflite/sqflite.dart';
class DBHelper{
  static Database? _db;
  static final int _vesion=2;
  static final String _tableName="tasks";
  static Future<void> initDb() async{
    if (_db!= null){
      return;
    }
    try{
      String _path =await getDatabasesPath()+'tasks.db';
      _db =await openDatabase(_path,
      version: _vesion,
        onCreate: (db,version){
        print("object");
        return db.execute("CREATE TABLE $_tableName("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "title STRING,note TEXT,date STRING,"
        "startTime STRING , endTime STRING,"
        "reminder INTEGER,repeat STRING,"
        "color INTEGER,"
            "isComplited  INTEGER)",);

        }
      );

    }
    catch(e){
      print(e);
    }
  }
  static Future<int> insert (Task? task) async {
    print("inserted");
    return await _db?.insert(_tableName, task!.toJson())??1;
  }
  static Future<List<Map<String,dynamic>>> query() async{
    return await _db!.query(_tableName);
  }
  static delete(Task task) async {
  await  _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }
  static update(int id) async{
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET isComplited = ?
    WHERE id = ?
    ''',[1, id]);

  }

}