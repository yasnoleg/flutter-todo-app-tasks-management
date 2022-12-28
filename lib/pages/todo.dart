import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo/data_base/databasehive.dart';
import 'package:todo/pages/drawerpage.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {

  //DataBase
  DataBase db = DataBase();

  //Date & Time
  DateTime nowdate = DateTime.now();
  DateTime current_date = DateTime.now();
  TimeOfDay timenow = TimeOfDay.now();

  //Vars
  bool checkvalue = false;
  double size1 = 100;
  double size2 = 100;
  double size3 = 60;

  //Audio
  late AudioPlayer player;
  
  

  //TextEditing Controllers
  TextEditingController Name = TextEditingController();
  TextEditingController StartTime = TextEditingController();
  TextEditingController DateTask = TextEditingController();

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

  //Lists
  List<int> NotYetTask = [];
  List<int> inProgressTask = [];
  List<int> TaskDone = [];

  //Save New CheckTask
  SaveNewCheckTask() {
    setState(() {
      db.CheckTodoMap.add({
        'name': Name.text.trim(),
        'starttime': StartTime.text.trim(),
        'checked': false,
        'date': DateTask.text.trim(),
        'inprogress': false,
      });
      db.CheckTodoUpdate();
    });
    FillTheLists();
    SetSizeOfLists();
    Navigator.of(context).pop();
  }

  //Reorder List 
  ReorderListIteam(int oldIndex, int newIndex) {
    //to solve the problem
    if(oldIndex < newIndex){
      newIndex--;
    }

    //Get the old index
    final tile = db.CheckTodoMap.removeAt(oldIndex);

    //Place it in the new index
    setState(() {
      db.CheckTodoMap.insert(newIndex, tile);
    });

    //Save it in the database
    db.CheckTodoUpdate();
  }

  //Delete CheckTask
  DeleteCheckTask(int index) {
    setState(() {
      db.CheckTodoMap.removeAt(index);
    });
    db.CheckTodoUpdate();
  }

  //Make the lists responseve
  FillTheLists() {
    setState(() {
      NotYetTask.clear();
      inProgressTask.clear();
      TaskDone.clear();
    });
    for(var i = 0; i<db.CheckTodoMap.length; i++){
      if(db.CheckTodoMap[i]['date'] == DateFormat('yyyy-MM-dd').format(current_date)) {
        if(db.CheckTodoMap[i]['checked'] == false && db.CheckTodoMap[i]['inprogress'] == false && db.CheckTodoMap[i]['checked'] == false){
          setState(() {
            NotYetTask.add(i);
          });
        }else if(db.CheckTodoMap[i]['inprogress'] == true && db.CheckTodoMap[i]['checked'] == false){
          setState(() {
            inProgressTask.add(i);
          });
        }else if(db.CheckTodoMap[i]['checked'] == true){
          setState(() {
            TaskDone.add(i);
          });
        }
      }
    }
  }

  //Set Size of Lists 
  SetSizeOfLists() {
    if(NotYetTask.length >= 4){
      setState(() {
        size1 = 250;
      });
    }else if(NotYetTask.length == 0){
      setState(() {
        size1 = 50;
      });
    }else{
      setState(() {
        size1 = NotYetTask.length * 70;
      });
    }

    if(inProgressTask.length >= 3){
      setState(() {
        size2 = 200;
      });
    }else if(inProgressTask.length == 0){
      setState(() {
        size2 = 50;
      });
    }else{
      setState(() {
        size2 = inProgressTask.length * 70;
      });
    }
    if(TaskDone.length >= 4){
      setState(() {
        size3 = 250;
      });
    }else{
      setState(() {
        size3 = TaskDone.length * 70;
      });
    }
  }

  @override
  void initState() {
    if(db.bx.get("Check") == null){
      db.CheckTodoInit();
    }else{
      db.CheckTodoLoad();
    }

    //init player music
    player = AudioPlayer()..setAsset('asset/sounddone.wav');

    Future.delayed(Duration.zero, (() {
      FillTheLists();
      SetSizeOfLists();
    }));
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    //Sizes
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () async {
            player.play();
          },
          child: Text('Todo',style: TextStyle(color: h1,fontFamily: 'h1',fontSize: 20),textAlign: TextAlign.center,)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(child: DrawerPage(),),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            //DatePicker
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
                      });
                      FillTheLists();
                      SetSizeOfLists();
                    },
                  ),
                ),
              ),
            ),
      
            //Tasks todo
            NotYetTask.length != 0 || inProgressTask.length != 0 || TaskDone.length != 0? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OwnFadeTransition(
                  curve: Curves.linear,
                  delayStart: Duration(milliseconds: 0),
                  animationDuration: Duration(milliseconds: 200),
                  offset: 5,
                  child: Padding(
                    padding: EdgeInsets.only(left: h*0.025,right: h*0.025,top: h*0.015),
                    child: Text('ToDo',style: TextStyle(color: h1,fontSize: h*0.025,fontWeight: FontWeight.w400,fontFamily: 'h2',letterSpacing: 2)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: h*0.01,bottom: h*0.005,right: h*0.025,left: h*0.025),
                  child: SizedBox(
                      height: size1,
                      child: ReorderableListView.builder(
                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        shrinkWrap: true,
                        itemCount: db.CheckTodoMap.length,
                        itemBuilder: ((context, index) {
                          final checktask = db.CheckTodoMap[index];
                          Future.delayed(Duration.zero, (() {
                            if(checktask['starttime'] == TimeOfDay(hour: timenow.hour, minute: timenow.minute).format(context)){
                              setState(() {
                                checktask['inprogress'] = true;
                              });FillTheLists();
                              SetSizeOfLists();
                            }
                          }));
                          return checktask['date'] == DateFormat('yyyy-MM-dd').format(current_date) ? checktask['inprogress'] == false && checktask['checked'] == false ? Dismissible(
                            key: ValueKey(checktask),
                            background: Container(
                              color: Colors.transparent,
                              child: Icon(Icons.remove_circle_outline,color: tasksredcolor),
                            ),
                            secondaryBackground: Container(
                              color: Colors.transparent,
                              child: Icon(Icons.play_arrow_outlined,color: buttoncolor),
                            ),
                            onDismissed: (direction) {
                              if(direction == DismissDirection.startToEnd){
                                DeleteCheckTask(index);
                              }else if(direction == DismissDirection.endToStart){
                                setState(() {
                                  checktask['inprogress'] = true;
                                });
                                db.CheckTodoUpdate();
                                FillTheLists();
                                SetSizeOfLists();
                              }
                            },
                            child: Padding(
                              key: ValueKey(checktask),
                              padding: EdgeInsets.only(bottom: h*0.02),
                              child: OwnFadeTransition(
                                curve: Curves.linear,
                                delayStart: Duration(milliseconds: 0),
                                animationDuration: Duration(milliseconds: 200),
                                offset: 5,
                                child: ListTile(
                                  key: ValueKey(checktask),
                                  title: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.02),
                                              child: Icon(Icons.menu,size: h*0.02,color: Colors.grey,),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 0,right: h * 0.02),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    checktask['checked'] = !checktask['checked'];
                                                  });
                                                  db.CheckTodoUpdate();
                                                  if(player.playing){
                                                    player.load();
                                                  }else{
                                                    player.play();
                                                  }
                                                  FillTheLists();
                                                  SetSizeOfLists();
                                                },
                                                child: AnimatedContainer(
                                                  duration: Duration(milliseconds: 700),
                                                  height: h * 0.03,
                                                  width: h * 0.03,
                                                  decoration: BoxDecoration(
                                                    color: checktask['checked'] == true ? tasksredcolor.withOpacity(0.4) : backgroundcolor.withOpacity(0.8),
                                                    border: Border.all(color: Colors.grey,width: 0.5),
                                                    borderRadius: BorderRadius.circular(h*0.01),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.3),
                                                        blurRadius: 5,
                                                        spreadRadius: 2,
                                                      ),
                                                    ]
                                                  ),
                                                  child: checktask['checked'] == true ? OwnFadeTransition(
                                                    curve: Curves.linear,
                                                    delayStart: Duration(milliseconds: 0),
                                                    animationDuration: Duration(milliseconds: 200),
                                                    offset: 5,
                                                    child: Icon(Icons.check,size: h*0.02,)) : Container(),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(checktask['name'],style: TextStyle(color: h1,fontSize: h*0.02,fontFamily: 'h1',fontWeight: FontWeight.w400),maxLines: 1,),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: w*0.03),
                                              child: Text('${checktask['starttime']}',style: TextStyle(color: h1,fontSize: h*0.018,fontFamily: 'h3',fontWeight: FontWeight.w300),maxLines: 1,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: h*0.09),
                                        child: Divider(
                                          color: Colors.grey.withOpacity(0.5),
                                          thickness: 0.5,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ) :Container(key: ValueKey(index)) : Container(key: ValueKey(index));
                        }), onReorder: (int oldIndex, int newIndex) { ReorderListIteam(oldIndex, newIndex); },
                      ),
                  ),
                ) 
              ],
            ) : Padding(
              padding: EdgeInsets.only(top: h * 0.1),
              child: OwnFadeTransition(
                  curve: Curves.elasticOut,
                  delayStart: Duration(milliseconds: 50),
                  animationDuration: Duration(milliseconds: 4500),
                  offset: 2,
                  child: Lottie.asset('icons/99955-empty-notifications.json',height: h * 0.3,width: h* 0.3),
                ),
            ),
      
            //Tasks inprogress
            inProgressTask.length != 0 ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OwnFadeTransition(
                  curve: Curves.linear,
                  delayStart: Duration(milliseconds: 0),
                  animationDuration: Duration(milliseconds: 200),
                  offset: 5,
                  child: Padding(
                    padding: EdgeInsets.only(left: h*0.025,right: h*0.025,top: 0),
                    child: Text('In Progress',style: TextStyle(color: h1,fontSize: h*0.025,fontWeight: FontWeight.w400,fontFamily: 'h2',letterSpacing: 2)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: h*0.01,bottom: h*0.005,right: h*0.025,left: h*0.025),
                  child: SizedBox(
                      height: size2,
                      child: ReorderableListView.builder(
                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        shrinkWrap: true,
                        itemCount: db.CheckTodoMap.length,
                        itemBuilder: ((context, index) {
                          final checktask = db.CheckTodoMap[index];
                          return checktask['date'] == DateFormat('yyyy-MM-dd').format(current_date) ? checktask['inprogress'] == true && checktask['checked'] == false ? Dismissible(
                            key: ValueKey(checktask),
                            background: Container(
                              color: Colors.transparent,
                              child: Icon(Icons.remove_circle_outline,color: tasksredcolor),
                            ),
                            secondaryBackground: Container(
                              color: Colors.transparent,
                              child: Icon(Icons.play_disabled_outlined,color: iconcolor),
                            ),
                            onDismissed: (direction) {
                              if(direction == DismissDirection.startToEnd){
                                DeleteCheckTask(index);
                              }else if(direction == DismissDirection.endToStart){
                                setState(() {
                                  checktask['inprogress'] = false;
                                });
                                db.CheckTodoUpdate();
                                FillTheLists();
                                SetSizeOfLists();
                              }
                            },
                            child: Padding(
                              key: ValueKey(checktask),
                              padding: EdgeInsets.only(bottom: h*0.02),
                              child: OwnFadeTransition(
                                curve: Curves.linear,
                                delayStart: Duration(milliseconds: 0),
                                animationDuration: Duration(milliseconds: 200),
                                offset: 5,
                                child: ListTile(
                                  key: ValueKey(checktask),
                                  title: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.02),
                                              child: Icon(Icons.menu,size: h*0.02,color: Colors.grey,),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 0,right: h * 0.02),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    checktask['checked'] = !checktask['checked'];
                                                  });
                                                  db.CheckTodoUpdate();
                                                  if(player.playing){
                                                    player.load();
                                                  }else{
                                                    player.play();
                                                  }
                                                  FillTheLists();
                                                  SetSizeOfLists();
                                                },
                                                child: AnimatedContainer(
                                                  duration: Duration(milliseconds: 700),
                                                  height: h * 0.03,
                                                  width: h * 0.03,
                                                  decoration: BoxDecoration(
                                                    color: checktask['checked'] == true ? tasksredcolor.withOpacity(0.4) : backgroundcolor.withOpacity(0.8),
                                                    border: Border.all(color: Colors.grey,width: 0.5),
                                                    borderRadius: BorderRadius.circular(h*0.01),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.3),
                                                        blurRadius: 5,
                                                        spreadRadius: 2,
                                                      ),
                                                    ]
                                                  ),
                                                  child: checktask['checked'] == true ? OwnFadeTransition(
                                                    curve: Curves.linear,
                                                    delayStart: Duration(milliseconds: 0),
                                                    animationDuration: Duration(milliseconds: 200),
                                                    offset: 5,
                                                    child: Icon(Icons.check,size: h*0.02,)) : Container(),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(checktask['name'],style: TextStyle(color: h1,fontSize: h*0.02,fontFamily: 'h1',fontWeight: FontWeight.w400),maxLines: 1,),
                                            ),
                                            checktask['inprogress'] == true && checktask['checked'] == false ? AvatarGlow(
                                              glowColor: buttoncolor,
                                              endRadius: h*0.02,
                                              duration: Duration(milliseconds: 2000),
                                              repeat: true,
                                              showTwoGlows: false,
                                              curve: Curves.fastOutSlowIn,
                                              child: Container(
                                                height: h*0.015,
                                                width: h*0.015,
                                                decoration: BoxDecoration(
                                                  color: buttoncolor,
                                                  borderRadius: BorderRadius.circular(100),
                                                ),
                                              ),
                                            ) : Container(),
                                            Padding(
                                              padding: EdgeInsets.only(left: w*0.03),
                                              child: Text('${checktask['starttime']}',style: TextStyle(color: checktask['starttime'] == TimeOfDay(hour: timenow.hour, minute: timenow.minute).format(context) ? buttoncolor : h1,fontSize: h*0.018,fontFamily: 'h3',fontWeight: FontWeight.w300),maxLines: 1,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: h*0.09),
                                        child: Divider(
                                          color: Colors.grey.withOpacity(0.5),
                                          thickness: 0.5,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ) :Container(key: ValueKey(index)) : Container(key: ValueKey(index));
                        }), onReorder: (int oldIndex, int newIndex) { ReorderListIteam(oldIndex, newIndex); },
                      ),
                  ),
                ),
              ],
            ) : Container(),
      
            //Tasks done
            TaskDone.length != 0 ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OwnFadeTransition(
                  curve: Curves.linear,
                  delayStart: Duration(milliseconds: 0),
                  animationDuration: Duration(milliseconds: 200),
                  offset: 5,
                  child: Padding(
                    padding: EdgeInsets.only(left: h*0.025,right: h*0.025,top: 0),
                    child: Text('Done',style: TextStyle(color: h1,fontSize: h*0.025,fontWeight: FontWeight.w400,fontFamily: 'h2',letterSpacing: 2)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: h*0.01,bottom: h*0.025,right: h*0.025,left: h*0.025),
                  child: SizedBox(
                      height: size3,
                      child: ReorderableListView.builder(
                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        shrinkWrap: true,
                        itemCount: db.CheckTodoMap.length,
                        itemBuilder: ((context, index) {
                          final checktask = db.CheckTodoMap[index];
                          return checktask['date'] == DateFormat('yyyy-MM-dd').format(current_date) ? checktask['checked'] == true ? Dismissible(
                            key: ValueKey(checktask),
                            background: Container(
                              color: Colors.transparent,
                              child: Icon(Icons.remove_circle_outline,color: tasksredcolor),
                            ),
                            secondaryBackground: Container(
                              color: Colors.transparent,
                              child: Icon(Icons.play_arrow_outlined,color: buttoncolor),
                            ),
                            onDismissed: (direction) {
                              if(direction == DismissDirection.startToEnd){
                                DeleteCheckTask(index);
                              }else if(direction == DismissDirection.endToStart){
                                setState(() {
                                  checktask['inprogress'] = true;
                                  checktask['checked'] = false;
                                });
                                db.CheckTodoUpdate();
                                FillTheLists();
                                SetSizeOfLists();
                              }
                            },
                            child: Padding(
                              key: ValueKey(checktask),
                              padding: EdgeInsets.only(bottom: h*0.02),
                              child: OwnFadeTransition(
                                curve: Curves.linear,
                                delayStart: Duration(milliseconds: 0),
                                animationDuration: Duration(milliseconds: 200),
                                offset: 5,
                                child: ListTile(
                                  key: ValueKey(checktask),
                                  title: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.02),
                                              child: Icon(Icons.menu,size: h*0.02,color: Colors.grey,),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 0,right: h * 0.02),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    checktask['checked'] = !checktask['checked'];
                                                  });
                                                  db.CheckTodoUpdate();
                                                  FillTheLists();
                                                  SetSizeOfLists();
                                                },
                                                child: AnimatedContainer(
                                                  duration: Duration(milliseconds: 700),
                                                  height: h * 0.03,
                                                  width: h * 0.03,
                                                  decoration: BoxDecoration(
                                                    color: checktask['checked'] == true ? tasksredcolor.withOpacity(0.4) : backgroundcolor.withOpacity(0.8),
                                                    border: Border.all(color: Colors.grey,width: 0.5),
                                                    borderRadius: BorderRadius.circular(h*0.01),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.3),
                                                        blurRadius: 5,
                                                        spreadRadius: 2,
                                                      ),
                                                    ]
                                                  ),
                                                  child: checktask['checked'] == true ? OwnFadeTransition(
                                                    curve: Curves.linear,
                                                    delayStart: Duration(milliseconds: 0),
                                                    animationDuration: Duration(milliseconds: 200),
                                                    offset: 5,
                                                    child: Icon(Icons.check,size: h*0.02,)) : Container(),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(checktask['name'],style: TextStyle(color: h1.withOpacity(0.5),fontSize: h*0.02,fontFamily: 'h1',fontWeight: FontWeight.w400,decoration: TextDecoration.lineThrough),maxLines: 1,),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: w*0.03),
                                              child: Text('${checktask['starttime']}',style: TextStyle(color: h1.withOpacity(0.5),fontSize: h*0.018,fontFamily: 'h3',fontWeight: FontWeight.w300,decoration: TextDecoration.lineThrough),maxLines: 1,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: h*0.09),
                                        child: Divider(
                                          color: Colors.grey.withOpacity(0.5),
                                          thickness: 0.5,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ) :Container(key: ValueKey(index)) : Container(key: ValueKey(index));
                        }), onReorder: (int oldIndex, int newIndex) { ReorderListIteam(oldIndex, newIndex); },
                      ),
                  ),
                ),
              ],
            ) : Container(),
          ],
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
                  child: AddTodoTask(Name: Name, StartTime: StartTime, onSaveNewCheckTask: () { SaveNewCheckTask(); }, DateTask: DateTask, WhenInProgressCheckTasks: () {  },),
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
    );
  }
}

//Page for adding new todo task
class AddTodoTask extends StatefulWidget {
  TextEditingController Name;
  TextEditingController StartTime;
  TextEditingController DateTask;
  VoidCallback onSaveNewCheckTask;
  VoidCallback WhenInProgressCheckTasks;
  AddTodoTask({super.key,
    required this.Name,
    required this.StartTime,
    required this.onSaveNewCheckTask,
    required this.WhenInProgressCheckTasks,
    required this.DateTask,
  });

  @override
  State<AddTodoTask> createState() => _AddTodoTaskState();
}

class _AddTodoTaskState extends State<AddTodoTask> {

  //DataBase
  DataBase db = DataBase();

  //Key
  final GlobalKey<FormState> _fromkey = GlobalKey<FormState>();

  //Date & Time 
  TimeOfDay start_time = TimeOfDay.now();
  DateTime date_task = DateTime.now();
  TimeOfDay timenow = TimeOfDay.now();

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


  @override
  void initState() {
    //db.bx.clear();
    if(db.bx.get("Check") == null){
      db.CheckTodoInit();
    }else{
      db.CheckTodoLoad();
    }
    if(db.bx.get("projects") == null){
      db.ProjectInit();
    }else{
      db.ProjectsLoad();
    }

    Future.delayed(Duration.zero, (() {
      widget.Name.clear();
      widget.StartTime.text = start_time.format(context);
      widget.DateTask.text = DateFormat('yyyy-MM-dd').format(date_task);
    }));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //sizes
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Padding(
        padding: EdgeInsets.only(left: h * 0.015,right: h * 0.015),
        child: Form(
          key: _fromkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left:  h * 0.015,top:  h * 0.015,right:  h * 0.015),
                child: Text('Name',style: TextStyle(color: h1,fontFamily: 'h2',fontSize: h * 0.025,fontWeight: FontWeight.w400),),
              ),
              Padding(
                padding: EdgeInsets.only(left:  h * 0.015,right:  h * 0.015,bottom:  h * 0.015),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                          return 'Please enter some name';
                        }
                      return null;
                    },
                    controller: widget.Name,
                    minLines: 1,
                    maxLines: 2,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: 'Add Task Name..',
                      fillColor: Color.fromARGB(92, 158, 158, 158),
                      filled: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 20,right: 15,bottom: 0),
                    child: Text('Start Time',style: TextStyle(color: h1,fontFamily: 'h1',fontWeight: FontWeight.w600,fontSize: 20),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 10,right: 15,bottom: 15),
                    child: GestureDetector(
                      onTap: () {
                        showTimePicker(
                          context: context, 
                          initialTime: TimeOfDay.now(),
                        ).then(((value) {
                          setState(() {
                            start_time = value!;
                            widget.StartTime.text = start_time.format(context);
                            //widget.StartTime.text = '${start_time.hour.toString()} : ${start_time.minute < 10 ? '0'+start_time.minute.toString() : start_time.minute.toString()}';
                          });
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 15,right: 15),
                        height: 50,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(92, 158, 158, 158),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.watch_later_outlined,color: Color.fromARGB(255, 199, 198, 198)),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text( start_time.format(context),style: TextStyle(color: Color.fromARGB(255, 199, 198, 198),fontSize: 16),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 20,right: 15,bottom: 0),
                    child: Text('Date',style: TextStyle(color: h1,fontFamily: 'h1',fontWeight: FontWeight.w600,fontSize: 20),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 10,right: 15,bottom: 15),
                    child: GestureDetector(
                      onTap: () {
                        showDatePicker(
                          context: context, 
                          firstDate: DateTime(2000), 
                          initialDate: date_task, 
                          lastDate: DateTime(2030),
                        ).then(((value) {
                          setState(() {
                            date_task = value!;
                            widget.DateTask.text = DateFormat('yyyy-MM-dd').format(date_task);
                            //widget.StartTime.text = '${start_time.hour.toString()} : ${start_time.minute < 10 ? '0'+start_time.minute.toString() : start_time.minute.toString()}';
                          });
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 15,right: 15),
                        height: 50,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(92, 158, 158, 158),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.watch_later_outlined,color: Color.fromARGB(255, 199, 198, 198)),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text( DateFormat('yyyy/MM/dd').format(date_task),style: TextStyle(color: Color.fromARGB(255, 199, 198, 198),fontSize: 16),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //Button
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.02,bottom: MediaQuery.of(context).size.height * 0.025,),
                    child: GestureDetector(
                      onTap: () {
                        if(_fromkey.currentState!.validate()){
                          widget.onSaveNewCheckTask();
                          if(start_time == TimeOfDay(hour: timenow.hour, minute: timenow.minute)){
                            widget.WhenInProgressCheckTasks();
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: 150,
                            decoration: BoxDecoration(
                              color: buttoncolor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text('Start',style: TextStyle(letterSpacing: 1,color: h1,fontFamily: 'h3',fontSize: 25,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                          ),
                        ],
                      ),
                    ),
                  ),
            ],
          ),
        ),
      )
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


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController firstRippleController;
  late AnimationController secondRippleController;
  late AnimationController thirdRippleController;
  late AnimationController centerCircleController;
  late Animation<double> firstRippleRadiusAnimation;
  late Animation<double> firstRippleOpacityAnimation;
  late Animation<double> firstRippleWidthAnimation;
  late Animation<double> secondRippleRadiusAnimation;
  late Animation<double> secondRippleOpacityAnimation;
  late Animation<double> secondRippleWidthAnimation;
  late Animation<double> thirdRippleRadiusAnimation;
  late Animation<double> thirdRippleOpacityAnimation;
  late Animation<double> thirdRippleWidthAnimation;
  late Animation<double> centerCircleRadiusAnimation;

  @override
  void initState() {
    firstRippleController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 2,
      ),
    );

    firstRippleRadiusAnimation = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(
        parent: firstRippleController,
        curve: Curves.ease,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          firstRippleController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          firstRippleController.forward();
        }
      });

    firstRippleOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: firstRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    firstRippleWidthAnimation = Tween<double>(begin: 10, end: 0).animate(
      CurvedAnimation(
        parent: firstRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    secondRippleController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 2,
      ),
    );

    secondRippleRadiusAnimation = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(
        parent: secondRippleController,
        curve: Curves.ease,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondRippleController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          secondRippleController.forward();
        }
      });

    secondRippleOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: secondRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    secondRippleWidthAnimation = Tween<double>(begin: 10, end: 0).animate(
      CurvedAnimation(
        parent: secondRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    thirdRippleController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 2,
      ),
    );

    thirdRippleRadiusAnimation = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(
        parent: thirdRippleController,
        curve: Curves.ease,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdRippleController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          thirdRippleController.forward();
        }
      });

    thirdRippleOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: thirdRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    thirdRippleWidthAnimation = Tween<double>(begin: 10, end: 0).animate(
      CurvedAnimation(
        parent: thirdRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );
    centerCircleController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    centerCircleRadiusAnimation = Tween<double>(begin: 35, end: 50).animate(
      CurvedAnimation(
        parent: centerCircleController,
        curve: Curves.fastOutSlowIn,
      ),
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            centerCircleController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            centerCircleController.forward();
          }
        },
      );

    firstRippleController.forward();
    Timer(
      Duration(milliseconds: 765),
      () => secondRippleController.forward(),
    );

    Timer(
      Duration(milliseconds: 1050),
      () => thirdRippleController.forward(),
    );

    centerCircleController.forward();

    super.initState();
  }

  @override
  void dispose() {
    firstRippleController.dispose();
    secondRippleController.dispose();
    thirdRippleController.dispose();
    centerCircleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(
        firstRippleRadiusAnimation.value,
        firstRippleOpacityAnimation.value,
        firstRippleWidthAnimation.value,
        secondRippleRadiusAnimation.value,
        secondRippleOpacityAnimation.value,
        secondRippleWidthAnimation.value,
        thirdRippleRadiusAnimation.value,
        thirdRippleOpacityAnimation.value,
        thirdRippleWidthAnimation.value,
        centerCircleRadiusAnimation.value,
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double firstRippleRadius;
  final double firstRippleOpacity;
  final double firstRippleStrokeWidth;
  final double secondRippleRadius;
  final double secondRippleOpacity;
  final double secondRippleStrokeWidth;
  final double thirdRippleRadius;
  final double thirdRippleOpacity;
  final double thirdRippleStrokeWidth;
  final double centerCircleRadius;

  MyPainter(
      this.firstRippleRadius,
      this.firstRippleOpacity,
      this.firstRippleStrokeWidth,
      this.secondRippleRadius,
      this.secondRippleOpacity,
      this.secondRippleStrokeWidth,
      this.thirdRippleRadius,
      this.thirdRippleOpacity,
      this.thirdRippleStrokeWidth,
      this.centerCircleRadius);

  @override
  void paint(Canvas canvas, Size size) {
    Color myColor = Color(0xff653ff4);

    Paint firstPaint = Paint();
    firstPaint.color = myColor.withOpacity(firstRippleOpacity);
    firstPaint.style = PaintingStyle.stroke;
    firstPaint.strokeWidth = firstRippleStrokeWidth;

    canvas.drawCircle(Offset.zero, firstRippleRadius, firstPaint);

    Paint secondPaint = Paint();
    secondPaint.color = myColor.withOpacity(secondRippleOpacity);
    secondPaint.style = PaintingStyle.stroke;
    secondPaint.strokeWidth = secondRippleStrokeWidth;

    canvas.drawCircle(Offset.zero, secondRippleRadius, secondPaint);

    Paint thirdPaint = Paint();
    thirdPaint.color = myColor.withOpacity(thirdRippleOpacity);
    thirdPaint.style = PaintingStyle.stroke;
    thirdPaint.strokeWidth = thirdRippleStrokeWidth;

    canvas.drawCircle(Offset.zero, thirdRippleRadius, thirdPaint);

    Paint fourthPaint = Paint();
    fourthPaint.color = myColor;
    fourthPaint.style = PaintingStyle.fill;

    canvas.drawCircle(Offset.zero, centerCircleRadius, fourthPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ControlleAudio extends StatelessWidget {
  ControlleAudio({super.key,
    required this.audioplayer,
  });

  final AudioPlayer audioplayer;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}