import 'dart:ffi';

import 'package:animated_button/animated_button.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:todo/Provider/percent_provider.dart';
import 'package:todo/data_base/databasehive.dart';
import 'package:todo/models/addtasks.dart';
import 'dart:async';

import 'package:todo/models/inforpage.dart';
import 'package:todo/pages/drawerpage.dart';
import 'package:todo/servecis/apinot.dart';


class DailyHomePage extends StatefulWidget {
  const DailyHomePage({super.key});

  @override
  State<DailyHomePage> createState() => _DailyHomePageState();
}

class _DailyHomePageState extends State<DailyHomePage> with SingleTickerProviderStateMixin {


  //Vars
  String colorselect = '#FF7285';
  TextEditingController indexcolor = TextEditingController();
  String _selectedrepeat = 'None';
  double done_percent = 0.0;

  //Controllers
  TextEditingController _titlecont = TextEditingController();
  TextEditingController _notescont = TextEditingController();
  TextEditingController starttime = TextEditingController();
  TextEditingController starthour = TextEditingController();
  TextEditingController endtime = TextEditingController();
  TextEditingController datetask = TextEditingController();
  TextEditingController repeatt = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController todocontent = TextEditingController();
  TextEditingController percentrage = TextEditingController();
  TextEditingController iconlink = TextEditingController();

  late AnimationController _controller;


  @override
  void dispose() {
    _titlecont.dispose();
    _notescont.dispose();
    starttime.dispose();
    endtime.dispose();
    datetask.dispose();
    repeatt.dispose();
    color.dispose();
    super.dispose();
  }


  //Add DataBase
  DataBase db = DataBase();

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
  HexColor tabbarcolor = HexColor('#404258');

  bool isFirst = true;
  bool isCheck = false;
  bool isStart = false;
  bool isEmptyList = false;
  bool isEmptyListchoosingdate = false;




  //Size 
  double listsize = 0;

  //time & date
  DateTime inday = DateTime.now();
  DateTime nowdate = DateTime.now();
  DateTime thisdate = DateTime.now();
  DateTime current_date = DateTime.now();
  TimeOfDay current_time = TimeOfDay.now();
  DateTime _timedate = DateTime.now();
  TimeOfDay start_time = TimeOfDay.now();
  TimeOfDay end_time = TimeOfDay.now();


  List<int> indexlist = [];
  List<int> indexlistchoosingdate = [];

  //Notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  

  //Save New Task
  void SaveNewTask(){
    setState(() {
      db.taskinfos.add([
        _titlecont.text.trim().toString(),
        _notescont.text.trim().toString(),
        starttime.text.trim(),
        endtime.text.trim(),
        datetask.text.trim(),
        repeatt.text.trim(),
        color.text.trim(),
        false,
        starthour.text.trim(),
        [],
        done_percent,
        iconlink.text.trim(),
        indexcolor.text.trim(),
      ]);
      db.sizecount = db.sizecount + 100;
    });
    db.UpdateData();
    indexlist.clear();
    AddIndex();
    QuickSortMaList();
    context.read<PercentUp>().initpercent();
  }

  //Delete Task
  DeleteTask(int element){
    setState(() {
      db.taskinfos.removeAt(element);
    });
    db.UpdateData();
    setState(() {
      indexlist.removeLast();
    });
    Navigator.of(context).pop();
  }

  //Task Done
  DoneTask(int thischild) {
    setState(() {
      db.taskinfos[thischild][10] = 1.0;
    });
    db.UpdateData();
    AnimationDone();
    Navigator.of(context).pop();
  } 

  //Edit Task
  EditTask(int once) {
    print('is work =======================');
    setState(() {
      db.taskinfos[once] = [
          _titlecont.text.trim().toString(),
          _notescont.text.trim().toString(),
          starttime.text.trim(),
          endtime.text.trim(),
          datetask.text.trim(),
          repeatt.text.trim(),
          color.text.trim(),
          db.taskinfos[once][7],
          starthour.text.trim(),
          db.taskinfos[once][9],
          db.taskinfos[once][10],
          iconlink.text.trim(),
          indexcolor.text.trim(),
      ];
    });
    db.UpdateData();
    if(db.taskinfos[once][4] != '${current_date.year}/${current_date.day}/${current_date.month}'){
      setState(() {
        indexlist.removeLast();
      });
    }
    QuickSortMaList();
    Navigator.of(context).pop();
  }

  //Switch false to true / true to false 'for todo list this task'
  Switch(int indexswitch){
    setState(() {
      db.taskinfos[indexswitch][7] = !db.taskinfos[indexswitch][7];
    });
    db.UpdateData();
  }

  //Add Sumi Todo List 'Todo List for this task only'
  AddTodoLine(int thisindex){
    setState(() {
      db.taskinfos[thisindex][9] = db.taskinfos[thisindex][9] + [ 
        [todocontent.text.trim(), isCheck]
      ];
    });
    db.UpdateData();
  }


  //to count number of tasks 
  AddIndex(){
    for (var i = 0; i < db.taskinfos.length; i++) {
      if('${current_date.year}/${current_date.day}/${current_date.month}' == db.taskinfos[i][4]){
        setState(() {
          indexlist.add(i);
          isEmptyList = false;
        });
      }else{
        setState(() {
          isEmptyList = true;
        });
      }
    }
  }

  //to count number of tasks 
  AddIndexChoosingDay(){
    for (var i = 0; i < db.taskinfos.length; i++) {
      if('${thisdate.year}/${thisdate.day}/${thisdate.month}' == db.taskinfos[i][4]){
        setState(() {
          indexlistchoosingdate.add(i);
          isEmptyListchoosingdate= false;
        });
      }else{
        setState(() {
          isEmptyListchoosingdate = true;
        });
      }
    }
  }


  
  //quick sort to order the tasks by start hour 
  int min = 0;
  List temp = [];
  QuickSortMaList() {
    for (var i = 0; i < db.taskinfos.length - 1; i++) {
      min = i;
      for (var j = i+1; j < db.taskinfos.length; j++) {
        if(int.parse(db.taskinfos[j][8]) < int.parse(db.taskinfos[min][8])){
          setState(() {
            min = j;
          });
        }
      }
      setState(() {
        temp = db.taskinfos[i];
        db.taskinfos[i] = db.taskinfos[min];
        db.taskinfos[min] = temp;
      });
    }
    db.UpdateData();
    Navigator.of(context).pop();
    _titlecont.clear();
    _notescont.clear();
    iconlink.clear();
    indexcolor.clear();
  }

  //Start animation done 
  AnimationDone() {
    Timer(Duration(seconds: 2), (() {
      _controller
        ..duration = Duration(seconds: 3)
        ..forward();
    }));
  }

  //init infrmation
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<PercentUp>().initpercent();
      AddIndex();
    });

    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3));


    //db.taskinfos.clear();
    //db.bx.clear();
    if(db.bx.get("todo") == null) {
      db.InitData();
    }else{
      db.LoadData();
    }

    if(db.bx.get("background") == null){
      db.BackInitData();
    }else{
      db.BackLoadData();
    }

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    ListViewTasksPerDay(DateTime CurrentDate) {
      return indexlistchoosingdate.isEmpty == false ? Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 20),
                child: Container(
                    //set container max/min height
                    constraints: BoxConstraints( 
                       minHeight: 500, //minimum height
                       minWidth: 300, // minimum width

                       maxHeight: MediaQuery.of(context).size.height,
                       //maximum height set to 100% of vertical height

                       maxWidth: MediaQuery.of(context).size.width,
                       //maximum width set to 100% of width
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          itemCount: db.taskinfos.length,
                          itemBuilder: (context, index) {
                            return '${CurrentDate.year}/${CurrentDate.day}/${CurrentDate.month}' == db.taskinfos[index][4] ? Padding(
                              padding: const EdgeInsets.only(top: 10,bottom: 10),
                              child: SlideFadeTransition(
                                curve: Curves.elasticOut,
                                delayStart: Duration(milliseconds: 100),
                                animationDuration: Duration(milliseconds: 2000),
                                offset: 2,
                                direction: Direction.horizontal,
                                child:Padding(
                                  padding: const EdgeInsets.only(left: 20,right: 20),
                                  child: Row( children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          alignment: Alignment.center,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: HexColor(db.taskinfos[index][6]),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 5),
                                                      child: Text(db.taskinfos[index][0],style: TextStyle(color: h1,fontSize: 20,fontFamily: 'h1',fontWeight: FontWeight.bold),),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 10),
                                                      child: Text(db.taskinfos[index][1],style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 15,fontFamily: 'h3',fontWeight: FontWeight.w500),maxLines: 2,),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 5),
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.alarm_on_outlined,size: 20,color: Colors.black.withOpacity(0.5),),
                                                          SizedBox(width: 10,),
                                                          Text(db.taskinfos[index][2] + ' - ' + db.taskinfos[index][3],style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 15,fontFamily: 'h3',fontWeight: FontWeight.w300),),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 5),
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.calendar_month_outlined,size: 20,color: Colors.black.withOpacity(0.5),),
                                                          SizedBox(width: 10,),
                                                          Text(db.taskinfos[index][4],style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 15,fontFamily: 'h3',fontWeight: FontWeight.w300),),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              CircularPercentIndicator(
                                                radius: 40,
                                                animation: true,
                                                animationDuration: 1500,
                                                lineWidth: 8,
                                                percent: context.watch<PercentUp>().TasksTasksList.isEmpty == true ? db.taskinfos[index][10] : context.watch<PercentUp>().TasksTasksList[index][10],
                                                progressColor: h1,
                                                backgroundColor: backgroundcolor.withOpacity(0.5),
                                                circularStrokeCap: CircularStrokeCap.round,
                                                center: Text(context.watch<PercentUp>().TasksTasksList.isEmpty == true ? '${(db.taskinfos[index][10]*100).toStringAsFixed(0)} %' : '${(context.watch<PercentUp>().TasksTasksList[index][10]*100).toStringAsFixed(0)} %',style: TextStyle(color: Colors.black.withOpacity(0.5),fontFamily: 'h2',fontSize: 20,fontWeight: FontWeight.bold),),
                                            ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                    ),
                                  ),
                            )) : Container();
                          },
                        ),
                    ),
                )) : OwnFadeTransition(
                  curve: Curves.elasticOut,
                  delayStart: Duration(milliseconds: 50),
                  animationDuration: Duration(milliseconds: 4500),
                  offset: 2,
                  child: Lottie.asset('icons/51382-astronaut-light-theme.json'),
                );
    }
    
    return Container(
        decoration: BoxDecoration(
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          drawer: DrawerPage(),
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text('Daily Tasks',style: TextStyle(color: h1,fontFamily: 'h1',fontSize: 20),textAlign: TextAlign.center,),
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //Month and day and button of add task
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 5,bottom: 0),
                                          child: Text('${DateFormat.MMMM().format(inday)} ${inday.day}',style: TextStyle(color: h1,fontFamily: 'h2',fontSize: 25,letterSpacing: 2),)),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5,bottom: 5),
                                          child: indexlist.length == 0 ? Text('start new task',style: TextStyle(color: per,fontFamily: 'per',fontSize: 14,letterSpacing: 1),) : Text('today you have ${indexlist.length} tasks',style: TextStyle(color: per,fontFamily: 'per',fontSize: 14,letterSpacing: 1),),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //days 
                  Padding(
                    padding: const EdgeInsets.only(top: 0,left: 20,right: 20,bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDatePicker(
                              context: context, 
                              initialDate: nowdate, 
                              firstDate: DateTime(2000), 
                              lastDate: DateTime(2030),
                              initialEntryMode: DatePickerEntryMode.calendar,
                            ).then(((value) {
                              setState(() {
                                thisdate = value!;
                              });
                              indexlistchoosingdate.clear();
                              AddIndexChoosingDay();
                              showModalBottomSheet(
                                context: context, 
                                backgroundColor: backgroundcolor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  )
                                ),
                                builder: ((context) {
                                  return SingleChildScrollView(
                                    physics: NeverScrollableScrollPhysics(),
                                    child: Column(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 10),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text('Tasks of : ${DateFormat.MMMM().format(thisdate)}  ${thisdate.day}  ${thisdate.year}',style: TextStyle(color: h1,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'h1'),textAlign: TextAlign.center,),
                                                  Expanded(
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: AnimatedButton(onPressed: (() { Navigator.of(context).pop(); }), 
                                                                width: 80,
                                                                height: 30,
                                                                child: Text('Back',style: TextStyle(color: h1,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'h2'))),
                                                            ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          SizedBox(
                                            height: 500,
                                            child: ListViewTasksPerDay(thisdate)),
                                        ],
                                    ),
                                  );
                                })
                              );
                            }));
                          },
                          child: Icon(Icons.arrow_forward_ios_outlined,size: 20,color: per,)
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15,right: 15),
                    child: Container(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.002,right: 5),
                      decoration: BoxDecoration(
                        color: backgroundcolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: DatePicker(
                          DateTime.utc(nowdate.year,nowdate.month,nowdate.day-2),
                          initialSelectedDate: DateTime.now(),
                          selectionColor: tasksredcolor,
                          selectedTextColor: Colors.white,
                          deactivatedColor: Colors.white,
                          dateTextStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                          ),
                          monthTextStyle: const TextStyle(
                            fontSize: 0,
                          ),
                          dayTextStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500
                          ),
                          daysCount: 60,
                          onDateChange: (date) {
                            // New date selected
                            setState(() {
                              current_date = date;
                              indexlist.clear();
                            });
                            AddIndex();
                            Timer(Duration(seconds: 2), (){
                              _controller
                                ..duration = Duration(seconds: 3)
                                ..forward();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  
                  //Tasks
                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 20),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.57,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: indexlist.isEmpty == false ? ListView.builder(
                            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                            itemCount: db.taskinfos.length,
                            itemBuilder: (context, index) {
                              Future.delayed(Duration.zero, (() {
                                db.taskinfos[index][10] != 1.0 ? '${current_date.year}/${current_date.day}/${current_date.month}' == db.taskinfos[index][4] ? Noti.showScheduledNotification(
                                  title: '${db.taskinfos[index][0]}', 
                                  body: '${db.taskinfos[index][1]}', 
                                  fln: flutterLocalNotificationsPlugin, 
                                  scheduledDate: DateTime((int.parse('${db.taskinfos[index][4][0]}${db.taskinfos[index][4][1]}${db.taskinfos[index][4][2]}${db.taskinfos[index][4][3]}')),(int.parse('${db.taskinfos[index][4][8]}${db.taskinfos[index][4][9]}')),(int.parse('${db.taskinfos[index][4][5]}${db.taskinfos[index][4][6]}')),(int.parse('${db.taskinfos[index][2][0]}${db.taskinfos[index][2][1]}')),(int.parse('${db.taskinfos[index][2][5]}${db.taskinfos[index][2][6]}')) )) : null : null;
                              }));
                              return '${current_date.year}/${current_date.day}/${current_date.month}' == db.taskinfos[index][4] ? Padding(
                                padding: const EdgeInsets.only(top: 10,bottom: 10),
                                child: SlideFadeTransition(
                                  curve: Curves.elasticOut,
                                  delayStart: Duration(milliseconds: 100),
                                  animationDuration: Duration(milliseconds: 2000),
                                  offset: 2,
                                  direction: Direction.horizontal,
                                  child:Padding(
                                    padding: const EdgeInsets.only(left: 20,right: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        print(db.taskinfos[index]);
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
                                                padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context).viewInsets.bottom
                                                ),
                                                child: InfoTaskLay(Title: db.taskinfos[index][0], Notes: db.taskinfos[index][1], StartTime: db.taskinfos[index][2], EndTime: db.taskinfos[index][3], Date: db.taskinfos[index][4], Colorr: db.taskinfos[index][6], Percent: db.taskinfos[index][10], Index: index, onDone: (() {
                                                  DoneTask(index);
                                                }), database: db, OnDeleteTask: () { DeleteTask(index); },title: _titlecont, notes: _notescont, startTime: starttime, endTime: endtime, dateOfTask: datetask, repeat: repeatt, colorSelect: color, onChangeTask: (() {
                                                  EditTask(index);
                                                }), startHour: starthour, onSwitch: (() {
                                                  Switch(index);
                                                }), TodoContent: todocontent, onAddTodoLine: () { AddTodoLine(index); }, IconSelect: iconlink, Repeat: isStart, Open: db.taskinfos[index][7], TodoThisTas: db.taskinfos[index][9], PercentTas: db.taskinfos[index][10], IconLink: db.taskinfos[index][11], IndexColor: indexcolor,),
                                            );
                                          })
                                        );
                                      },
                                      child: Container(
                                            padding: EdgeInsets.all(0),
                                            alignment: Alignment.center,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: HexColor(db.taskinfos[index][6]),
                                            ),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                      padding: const EdgeInsets.all(10),
                                                      child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.only(bottom: 5),
                                                                child: Text(db.taskinfos[index][0],style: TextStyle(color: h1,fontSize: 20,fontFamily: 'h1',fontWeight: FontWeight.bold),maxLines: 1,),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(bottom: 10),
                                                                child: Text(db.taskinfos[index][1],style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 15,fontFamily: 'h3',fontWeight: FontWeight.w500),maxLines: 2,),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(bottom: 5),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons.alarm_on_outlined,size: 20,color: Colors.black.withOpacity(0.5),),
                                                                    SizedBox(width: 10,),
                                                                    Text(db.taskinfos[index][2] + ' - ' + db.taskinfos[index][3],style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 15,fontFamily: 'h3',fontWeight: FontWeight.w300),),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(bottom: 5),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons.calendar_month_outlined,size: 20,color: Colors.black.withOpacity(0.5),),
                                                                    SizedBox(width: 10,),
                                                                    Text(db.taskinfos[index][4],style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 15,fontFamily: 'h3',fontWeight: FontWeight.w300),),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        CircularPercentIndicator(
                                                            radius: 40,
                                                            animation: true,
                                                            animationDuration: 1500,
                                                            lineWidth: 8,
                                                            percent: context.watch<PercentUp>().TasksTasksList.isEmpty == true ? db.taskinfos[index][10] : context.watch<PercentUp>().TasksTasksList[index][10],
                                                            progressColor: h1,
                                                            backgroundColor: backgroundcolor.withOpacity(0.5),
                                                            circularStrokeCap: CircularStrokeCap.round,
                                                            center: Text(context.watch<PercentUp>().TasksTasksList.isEmpty == true ? '${(db.taskinfos[index][10]*100).toStringAsFixed(0)} %' : '${(context.watch<PercentUp>().TasksTasksList[index][10]*100).toStringAsFixed(0)} %',style: TextStyle(color: Colors.black.withOpacity(0.5),fontFamily: 'h2',fontSize: 20,fontWeight: FontWeight.bold),),
                                                        ),
                                                      ],
                                                  ),
                                                ),

                                                db.taskinfos[index][10] == 1.0 ? Align(
                                                  alignment: Alignment(1,-1),
                                                  child: Lottie.asset('icons/99911-win-animation.json',height: 30,width: 30,repeat: false),
                                                ) : Container(),
                                              ],
                                            ),
                                          ),
                                    ),
                                  ),
                              )) : Container();
                            },
                          ) : OwnFadeTransition(
                            curve: Curves.elasticOut,
                            delayStart: Duration(milliseconds: 50),
                            animationDuration: Duration(milliseconds: 4500),
                            offset: 2,
                            child: Lottie.asset('icons/51382-astronaut-light-theme.json'),
                          ),
                        ),
                      ),
                    ),
                 ]
                ),
            ),
            floatingActionButton: GestureDetector(
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
                                    child: AddTasksPage(Title: _titlecont, Notes: _notescont, StartTime: starttime, EndTime: endtime, DateOfTask: datetask, Repeat: repeatt, ColorSelect: color, isFirst: isFirst, OnSaveTask: (() {
                                      SaveNewTask();
                                    }), StartHour: starthour, IconSelect: iconlink, IndexColor: indexcolor,),
                                  );
                                })
                              );
                            //Navigator.push(context,MaterialPageRoute(builder: ((context) => AddTasksPage(Title: _titlecont, Notes: _notescont, StartTime: start_time, EndTime: end_time, DateOfTask: _timedate, Repeat: _selectedrepeat, ColorSelect: colorselect, isFirst: isFirst, OnSaveTask: SaveNewTask))));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: AvatarGlow(
                              glowColor: h1,
                              endRadius: 50,
                              duration: Duration(milliseconds: 4000),
                              repeat: true,
                              showTwoGlows: true,
                              curve: Curves.fastOutSlowIn,
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: buttoncolor, 
                                  borderRadius: BorderRadius.circular(99)
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: h1,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
          ),
    );
  }
}

enum Direction { vertical, horizontal }

class SlideFadeTransition extends StatefulWidget {
  final Widget child;

  final double offset;

  final Curve curve;

  final Direction direction;

  final Duration delayStart;

  final Duration animationDuration;

  SlideFadeTransition({
    required this.child,
    this.offset = 1.0,
    this.curve = Curves.easeIn,
    this.direction = Direction.vertical,
    this.delayStart = const Duration(seconds: 0),
    this.animationDuration = const Duration(milliseconds: 800),
  });

  @override
  _SlideFadeTransitionState createState() => _SlideFadeTransitionState();
}

class _SlideFadeTransitionState extends State<SlideFadeTransition>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animationSlide;

  late AnimationController _animationController;

  late Animation<double> _animationFade;


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    if (widget.direction == Direction.vertical) {
      _animationSlide =
          Tween<Offset>(begin: Offset(0, widget.offset), end: Offset(0, 0))
              .animate(CurvedAnimation(
        curve: widget.curve,
        parent: _animationController,
      ));
    } else {
      _animationSlide =
          Tween<Offset>(begin: Offset(widget.offset, 0), end: Offset(0, 0))
              .animate(CurvedAnimation(
        curve: widget.curve,
        parent: _animationController,
      ));
    }

    _animationFade =
        Tween<double>(begin: -1.0, end: 1.0).animate(CurvedAnimation(
      curve: widget.curve,
      parent: _animationController,
    ));

    Timer(widget.delayStart, () {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationFade,
      child: SlideTransition(
        position: _animationSlide,
        child: widget.child,
      ),
    );
  }
}


//Fade Animation
class OwnFadeTransition extends StatefulWidget {
  final Widget child;

  final double offset;

  final Curve curve;

  final Duration delayStart;

  final Duration animationDuration;

  OwnFadeTransition({
    required this.child,
    this.offset = 1.0,
    this.curve = Curves.easeIn,
    this.delayStart = const Duration(seconds: 0),
    this.animationDuration = const Duration(milliseconds: 800),
  });

  @override
  _OwnFadeTransitionState createState() => _OwnFadeTransitionState();
}

class _OwnFadeTransitionState extends State<OwnFadeTransition>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  late Animation<double> _animationFade;


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );


    _animationFade =
        Tween<double>(begin: -1.0, end: 1.0).animate(CurvedAnimation(
      curve: widget.curve,
      parent: _animationController,
    ));

    Timer(widget.delayStart, () {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationFade,
      child: widget.child,
    );
  }
}



