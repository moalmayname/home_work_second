import 'package:get/get.dart';
import 'package:home_work_second/DB/DbHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:home_work_second/Model/task.dart';
class TaskControler extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }
  var taskList= <Task>[].obs;
  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }
  void getTasks() async{
    List<Map<String,dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromjson(data)).toList());
  }
  void delete(Task task){
    DBHelper.delete(task);
    getTasks();

  }
  void TaskComplted(int id ) async {
    await  DBHelper.update(id);
    getTasks();
  }
}