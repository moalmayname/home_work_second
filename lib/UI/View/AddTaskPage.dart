import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_work_second/Controler/controler.dart';
import 'package:home_work_second/Model/task.dart';
import 'package:home_work_second/Services/themeServices.dart';
import 'package:home_work_second/UI/View/HomePage.dart';
import 'package:home_work_second/UI/Widget/button.dart';
import 'package:intl/intl.dart';

import '../Widget/input_field.dart';
import '../theme.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskControler _taskControler= Get.put(TaskControler());
  final TextEditingController _titleControler= TextEditingController();
  final TextEditingController _hintControler= TextEditingController();
  DateTime _selctedDate =DateTime.now();
  String _enddTime="9:30 PM";
  String _startedTime=DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectReminder = 5;
  List<int> reminderList=[
    5,10,15,20
  ];
  String _selectRepaet = "None";
  List<String> RepaetList=[
    "None",
    "Daily",
    "Wekly",
    "Monthly"
  ];
  int _selctedColor= 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar:AppBar(
        backgroundColor:
        context.theme.backgroundColor,
        elevation: 0,


        leading: GestureDetector(

          onTap:() {
            Get.back();

          },
          child: Icon( Icons.arrow_back_ios_rounded,
              color: Get.isDarkMode? Colors.white:Colors.black),

        ) ,
        actions: [
          Icon(Icons.person,size: 20,),
          SizedBox(width: 20,),

        ],


      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Task",style: headingStyle,),
              MyInputField(title: "Tilte", hint: "Enter Your title",controller: _titleControler,),
              MyInputField(title: "Note", hint: "Enter Your Note",controller: _hintControler,),
              MyInputField(title: "Date", hint: DateFormat.yMd().format(_selctedDate),
                widget: IconButton(icon: Icon(Icons.calendar_month_rounded),
                  onPressed: () {
                    _getDateFromUser();

                  },

                ) ,
              ),
              Row(
                children: [
                  Expanded(child: MyInputField(title: "startDate", hint: _startedTime,
                    widget: IconButton(
                      onPressed: (){
                        _getTimeFromUser(isStartTime:true);
                      },
                      icon: Icon(Icons.access_time_rounded,
                        color: Colors.grey,),
                    ),
                  ),
                  ),
                  SizedBox(width: 12,),
                  Expanded(child: MyInputField(title: "endDate", hint: _enddTime,
                    widget: IconButton(
                      onPressed: (){
                        _getTimeFromUser(isStartTime:false);
                      },
                      icon: Icon(Icons.access_time_rounded,
                        color: Colors.grey,),
                    ),
                  ),
                  ),


                ],
              ),
              SizedBox(height: 20,),(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start
                  )

              ),
              MyInputField(title: "Rimender", hint: "$_selectReminder MinutsEarly",
              widget: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey),
                iconSize: 32,
                elevation: 4,
                style: subtitleStyle,
                items: reminderList.map<DropdownMenuItem<String>>((int value){
                  return DropdownMenuItem(
                    value: value.toString(),
                      child: Text(value.toString()));
                }
                ).toList(),
                underline: Container(height: 0,),
                onChanged:
                (String? newValue){
                  setState(() {
                    _selectReminder =int.parse(newValue!);
                  });
                },
              ),
              ),
              MyInputField(title: "Repater", hint: "$_selectRepaet ",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey),
                  iconSize: 32,
                  elevation: 4,
                  style: subtitleStyle,
                  items: RepaetList.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: Colors.grey),));
                  }
                  ).toList(),
                  underline: Container(height: 0,),
                  onChanged:
                      (String? newValue){
                    setState(() {
                      _selectRepaet =newValue!;
                    });
                  },
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text("Color ", style: titleStyle,),
                      SizedBox(height: 9,),
                      Wrap(
                        children: List<Widget>.generate(
                          3,
                            (int index){
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  _selctedColor= index;
                                });

                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: index==0?primaryColor:index==1?pinkColor:yellowlColor,
                                  child:_selctedColor==index? Icon(Icons.done,
                                  color: Colors.white,
                                  size: 16,):Container(),



                                ),
                              ),
                            );
                            }
                        ),
                      ),

                    ],
                  ),
                  MyButton(label: "CreateTask", onTap: ()=> _addTask())
                ],
              )









            ],
          ),
        ),
      ),
    );
  }
  _addTask() async {
    int value= await _taskControler.addTask(
        task:Task(

          note: _hintControler.text,
          title: _titleControler.text,
          date: DateFormat.yMd().format(_selctedDate),
          startTime: _startedTime,
          endTime: _enddTime,
          reminder: _selectReminder,
          repeat: _selectRepaet,
          color: _selctedColor,
          isComplited: 0,
        )
    );
    Get.back();

  }
  _valedateMethod(){
    if (_titleControler.text.isNotEmpty&& _hintControler.text.isNotEmpty){
      Get.back();
    }
    else if (_titleControler.text.isEmpty || _hintControler.text.isEmpty){
      Get.snackbar("Reqaired", "All The field Are Reqaired",
      snackPosition:SnackPosition.BOTTOM,
      backgroundColor: Colors.white,icon: Icon(Icons.warning_rounded));
    }
  }
  _getDateFromUser() async {
    DateTime? _datePicker=await  showDatePicker(context: context, initialDate: DateTime.now(),firstDate: DateTime(2015), lastDate: DateTime(2030));
    if (_datePicker!= null){
      _selctedDate =_datePicker;


    }
    else{
      print("ob");

    }
  }
  _getTimeFromUser(  {required bool isStartTime})async{
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime==null){
      print("");
    }
    else if (isStartTime==true){
      setState(() {
        _startedTime=_formatedTime;
      });;
    }
    else if (isStartTime==false){
      setState(() {
        _enddTime=_formatedTime;
      });

    }

  }
  _showTimePicker(){
    return showTimePicker(initialEntryMode: TimePickerEntryMode.input,context: context, initialTime: TimeOfDay(hour:int.parse(_startedTime.split(":")[0]), minute: int.parse(_startedTime.split(":")[1].split(" ")[0]),));
  }

}
