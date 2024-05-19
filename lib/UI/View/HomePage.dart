import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_work_second/Controler/controler.dart';
import 'package:home_work_second/Model/task.dart';
import 'package:home_work_second/Services/task_title.dart';
import 'package:home_work_second/UI/Widget/button.dart';
import 'package:home_work_second/UI/theme.dart';
import 'package:home_work_second/UI/View/AddTaskPage.dart';
import 'package:home_work_second/Services/themeServices.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selctedDate= DateTime.now();
  final _taskController =Get.put(TaskControler());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:
        context.theme.backgroundColor,
        elevation: 0,


        leading: GestureDetector(

          onTap:() {
            ThemeSerivce().switchTheme();

          },
          child: Icon( Get.isDarkMode?Icons.sunny:Icons.nightlight_sharp,size: 20,
              color: Get.isDarkMode? Colors.white:Colors.black),

        ) ,
        actions: [
          Icon(Icons.person,size: 20,),
          SizedBox(width: 20,),

        ],


      ),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(height: 10,),
          showTasks(),
        ],
      ),

    );
  }
  _addDateBar(){
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
          DateTime.now(),
          height: 100,
          width: 80,
          initialSelectedDate: DateTime.now(),
          selectionColor: primaryColor,
          selectedTextColor: whiteColor,
          dateTextStyle:TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.grey,

            ),



          onDateChange: (date){
            _selctedDate= date;

          }

      ),
    );
  }
  _addTaskBar(){
   return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row

        ( mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat.yMMMEd().format(DateTime.now()),style:
              subHeadingStyle,),
              Text("Today"),
            ],
          ),
        ),
        MyButton(label: "+AddTask",onTap: ()async{ await Get.to(AddTaskPage());
        _taskController.getTasks();}),

      ],),
    );
  }


  showTasks(){
    return Expanded(
      child: Obx((){
        return  ListView.builder(

          itemCount: _taskController.taskList.length,
            itemBuilder: (_,index){

            print(_taskController.taskList.length);
           return AnimationConfiguration.staggeredList(position: index, child: SlideAnimation(
              child: FadeInAnimation(

                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        showBottomSheet(context,   _taskController.taskList[index]);


                      },

                      child: TaskTile(
                        _taskController.taskList[index]

                      ),


                    )
                  ],

                ),
              ),
            ),);



        });
      }),
    );
  }
  showBottomSheet(BuildContext context, Task task){
   return Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isComplited==1?
         MediaQuery.of(context).size.height*0.24:
            MediaQuery.of(context).size.height*0.32,
          color: Get.isDarkMode?darkGreyColor:Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
              ),
            ),
            Spacer(),
            task.isComplited==1?Container():
                bottomSheetButton(label: "TaskCompleted", onTap:() {
                  Get.back();
                  _taskController.TaskComplted(task.id!);


                }, clr: primaryColor,
                context: context),
            SizedBox(height: 15,),
            bottomSheetButton(label: "Delete Task", onTap:() {
              Get.back();
              _taskController.delete(task);


            }, clr: Colors.redAccent,
                context: context),
            SizedBox(height: 25),
            bottomSheetButton(label: "Close", onTap:() {
              Get.back();
            }, clr: Colors.redAccent,
                context: context,
            isClose: true),
          ],
        ),
      ),
    );
  }
  bottomSheetButton({
   required String label,
   required Function()? onTap,
   required Color clr,
    bool  isClose=false,
    required BuildContext context,
}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,

        decoration: BoxDecoration(
          color:isClose==true?Get.isDarkMode?Colors.grey[600]:Colors.grey[300]:clr,

          border: Border.all(
        color: isClose==true?Colors.transparent:clr,
            width: 2,

          ),
          borderRadius: BorderRadius.circular(25),

        ),
        child: Center(
          child: Text(
            label,
            style: isClose?titleStyle:titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

}
