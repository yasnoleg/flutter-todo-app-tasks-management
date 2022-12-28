// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/percent_provider.dart';
import 'package:todo/data_base/databasehive.dart';
import 'package:todo/models/edit_task_icon.dart';
import 'package:todo/models/edittask.dart';
import 'package:todo/models/inforpage.dart';
import 'package:todo/models/percent_slider.dart';
import 'package:todo/models/todo_for_this_task.dart';

class InfoTaskPage extends StatefulWidget {
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
  InfoTaskPage({super.key,
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
  State<InfoTaskPage> createState() => _InfoTaskPageState();
}

class _InfoTaskPageState extends State<InfoTaskPage> {
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


  int _selectedIndex = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.Title,style: TextStyle(fontSize: 20,fontFamily: 'h1',fontWeight: FontWeight.bold,color: h1)),
        centerTitle: true,
        backgroundColor: backgroundcolor,
      ),
      body: SingleChildScrollView(
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
                    EditTaskIcon(database: widget.database, Index: widget.Index),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.alarm_on_outlined,size: 20,color: h1.withOpacity(0.5),),
                                SizedBox(width: 10,),
                                Text(widget.StartTime + ' - ' + widget.EndTime,style: TextStyle(color: h1.withOpacity(0.5),fontSize: 15,fontFamily: 'h3',fontWeight: FontWeight.w300),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_month_outlined,size: 25,color: h1.withOpacity(0.5),),
                                SizedBox(width: 10,),
                                Text(widget.Date,style: TextStyle(color: h1.withOpacity(0.5),fontSize: 15,fontFamily: 'h3',fontWeight: FontWeight.w300),),
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
                            child: Text(widget.Notes,style: TextStyle(fontSize: 15,fontFamily: 'h3',fontWeight: FontWeight.w300,color: h1.withOpacity(0.5),),maxLines: 2,),
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
                  database: widget.database, Index: widget.Index, PercentTas: widget.Percent,
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 0,bottom: 0),
                child: TodoForTask(database: widget.database, Index: widget.Index, onSwitch: widget.onSwitch, TodoContent: widget.TodoContent, onAddTodoLine: widget.onAddTodoLine,),
              ),
            ],
          ),
        )),
      bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: GNav(
                haptic: false,
                gap: 8,
                activeColor: h1.withOpacity(0.5),
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[800]!,
                color: h1.withOpacity(0.5),
                backgroundColor: Colors.grey[800]!,
                tabs: [
                  GButton(
                    icon: Icons.done_rounded,
                    text: 'Done',
                    iconColor: buttoncolor,
                    iconActiveColor: buttoncolor,
                    iconSize: 35,
                    textStyle: TextStyle(color: buttoncolor,fontSize: 20,fontFamily: 'h3',fontWeight: FontWeight.w500)
                  ),
                  GButton(
                    icon: Icons.edit,
                    text: 'Edit',
                    iconColor: tasksredcolor,
                    iconActiveColor: tasksredcolor,
                    iconSize: 35,
                    textStyle: TextStyle(color: tasksredcolor,fontSize: 20,fontFamily: 'h3',fontWeight: FontWeight.w500)
                  ),
                  const GButton(
                    icon: Icons.delete_outline_outlined,
                    text: 'Delete',
                    iconColor: Colors.red,
                    iconActiveColor: Colors.red,
                    iconSize: 35,
                    textStyle: TextStyle(color: Colors.red,fontSize: 20,fontFamily: 'h3',fontWeight: FontWeight.w500)
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  if(index == 0){
                    widget.onDone();
                    context.read<PercentUp>().donepercent(1.0);
                  }
                  if(index == 1){
                    Future.delayed(Duration(milliseconds: 500), () {
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
                            child: EditTasksPage(Title: widget.title, Notes: widget.notes, StartTime: widget.startTime, StartHour: widget.startHour, EndTime: widget.endTime, DateOfTask: widget.dateOfTask, Repeat: widget.repeat, ColorSelect: widget.colorSelect, onEditTask: widget.onChangeTask, IconSelect: widget.IconSelect, readtitle: widget.Title, readnotes: widget.Notes, readstart_time: widget.StartTime, readend_time: widget.EndTime, readdate: widget.Date, readiconlink: widget.database.taskinfos[widget.Index][11], IndexColor: widget.IndexColor, readiconlindex: (widget.IndexColor.text).toString(), Index: widget.Index,));
                        })
                      );
                    });
                  }
                  if(index == 2){
                    Future.delayed(Duration(milliseconds: 500), () {
                      widget.OnDeleteTask();
                    });
                  }
                },
              ),
            ),
          ),
        )

    );
    
  }
}