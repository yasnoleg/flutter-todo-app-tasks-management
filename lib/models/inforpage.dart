// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/percent_provider.dart';
import 'package:todo/data_base/databasehive.dart';
import 'package:todo/models/edit_task_icon.dart';
import 'package:todo/models/edittask.dart';
import 'package:todo/models/info_allpage.dart';
import 'package:todo/models/percent_slider.dart';
import 'package:todo/models/todo_for_this_task.dart';

class InfoTaskLay extends StatelessWidget {
  String Title;
  String Notes;
  String StartTime;
  String EndTime;
  String Date;
  bool Repeat;
  String Colorr;
  double Percent;
  int Index;
  VoidCallback onDone;
  DataBase database;
  VoidCallback OnDeleteTask;
  VoidCallback onSwitch;
  TextEditingController TodoContent;
  TextEditingController IconSelect;

  final title;
  final notes;
  TextEditingController startTime;
  TextEditingController startHour;
  TextEditingController endTime;
  TextEditingController dateOfTask;
  TextEditingController repeat;
  TextEditingController colorSelect;
  VoidCallback onChangeTask;
  VoidCallback onAddTodoLine;
  bool Open;
  List TodoThisTas;
  double PercentTas;
  String IconLink;
  TextEditingController IndexColor;
  InfoTaskLay({super.key,
  required this.Title,
  required this.Notes,
  required this.StartTime,
  required this.EndTime,
  required this.Date,
  required this.Colorr,
  required this.Percent,
  required this.Index,
  required this.onDone,
  required this.database,
  required this.OnDeleteTask,
  required this.title,
  required this.notes,
  required this.startTime,
  required this.startHour,
  required this.endTime,
  required this.dateOfTask,
  required this.repeat,
  required this.colorSelect,
  required this.onChangeTask,
  required this.onSwitch,
  required this.TodoContent,
  required this.onAddTodoLine,
  required this.IconSelect,
  required this.Repeat,
  required this.Open,
  required this.TodoThisTas,
  required this.PercentTas,
  required this.IconLink,
  required this.IndexColor,
  });

  @override
  Widget build(BuildContext context) {
  //COLORS
  HexColor buttoncolor = HexColor('#8280FF');
  HexColor tasksredcolor = HexColor('#FF7285');
  HexColor tasksyelcolor = HexColor('#FFCA83');
  HexColor tasksgrecolor = HexColor('#4AD991');
  HexColor iconcolor = HexColor('#B4B4C6');
  HexColor morningcolor = HexColor('#ffe9a6');
  Color backgroundcolor = Colors.black;
  Color backgroundcolor2 = Colors.white;
  Color h1 = Colors.white;
  Color per = Colors.grey;
  Color inactivtasks = Colors.grey.shade400;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: Row(
                children: [
                  EditTaskIcon(database: database, Index: Index),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(Title,style: TextStyle(fontSize: 20,fontFamily: 'h1',fontWeight: FontWeight.bold,color: h1))
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => InfoTaskPage(Title: Title, Notes: Notes, StartTime: StartTime, EndTime: EndTime, Date: Date, Colorr: Colorr, Percent: Percent, Index: Index, onDone: onDone, database: database, OnDeleteTask: OnDeleteTask, title: title, notes: notes, startTime: startTime, startHour: startHour, endTime: endTime, dateOfTask: dateOfTask, repeat: repeat, colorSelect: colorSelect, onChangeTask: onChangeTask, onSwitch: onSwitch, TodoContent: TodoContent, onAddTodoLine: onAddTodoLine, IconSelect: IconSelect, Repeat: Repeat, Open: Open, TodoThisTas: TodoThisTas, PercentTas: PercentTas, IconLink: IconLink, IndexColor: IndexColor)
                                    ),
                                  );
                                },
                                child: Icon(Icons.expand_less_outlined,size: 20,color: per,))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.alarm_on_outlined,size: 20,color: h1.withOpacity(0.5),),
                              SizedBox(width: 10,),
                              Text(StartTime + ' - ' + EndTime,style: TextStyle(color: h1.withOpacity(0.5),fontSize: 15,fontFamily: 'h3',fontWeight: FontWeight.w300),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_month_outlined,size: 25,color: h1.withOpacity(0.5),),
                              SizedBox(width: 10,),
                              Text(Date,style: TextStyle(color: h1.withOpacity(0.5),fontSize: 15,fontFamily: 'h3',fontWeight: FontWeight.w300),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 105,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10)
                      ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Text('Description',style: TextStyle(fontSize: 20,fontFamily: 'h2',fontWeight: FontWeight.w500,color: h1),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(Notes,style: TextStyle(fontSize: 15,fontFamily: 'h3',fontWeight: FontWeight.w300,color: h1.withOpacity(0.5),),maxLines: 2,),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 0,bottom: 10),
              child: PercentSlider(
                database: database, Index: Index, PercentTas: Percent,
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 0,bottom: 0),
              child: TodoForTask(database: database, Index: Index, onSwitch: onSwitch, TodoContent: TodoContent, onAddTodoLine: onAddTodoLine,),
            ),


            Padding(
              padding: EdgeInsets.only(top: 10,bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      onDone();
                      context.read<PercentUp>().donepercent(1.0);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color: buttoncolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Done',style: TextStyle(color: h1,fontSize: 20,fontFamily: 'h3',fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                    ),
                  ),
                  SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )
                        ),
                        builder: ((context) {
                          return Container(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: EditTasksPage(Title: title, Notes: notes, StartTime: startTime, StartHour: startHour, EndTime: endTime, DateOfTask: dateOfTask, Repeat: repeat, ColorSelect: colorSelect, onEditTask: onChangeTask, IconSelect: IconSelect, readtitle: Title, readnotes: Notes, readstart_time: StartTime, readend_time: EndTime, readdate: Date, readiconlink: database.taskinfos[Index][11], IndexColor: IndexColor, readiconlindex: (IndexColor.text).toString(), Index: Index,));
                        })
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color: tasksredcolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Edit',style: TextStyle(color: h1,fontSize: 20,fontFamily: 'h3',fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                    ),
                  ),
                  SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () {
                      OnDeleteTask();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Delete',style: TextStyle(color: h1,fontSize: 20,fontFamily: 'h3',fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
  }
}