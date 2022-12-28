import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo/Provider/background_provider.dart';
import 'package:todo/data_base/databasehive.dart';
import 'package:todo/pages/drawerpage.dart';
import 'package:todo/pages/todo.dart';

class ProjectTodoPage extends StatefulWidget {
  int Index;
  VoidCallback WhenAddCheckTasks;
  VoidCallback WhenDeleteCheckTasks;
  VoidCallback WhenUnderDoneCheckTask;
  VoidCallback WhenDoneCheckTasks;
  VoidCallback WhenInProgressCheckTasks;
  VoidCallback WhenNotYetinProgressCheckTask;
  ProjectTodoPage({super.key,
    required this.Index, 
    required this.WhenAddCheckTasks, 
    required this.WhenDeleteCheckTasks,
    required this.WhenDoneCheckTasks, 
    required this.WhenUnderDoneCheckTask,
    required this.WhenInProgressCheckTasks,
    required this.WhenNotYetinProgressCheckTask,
  });

  @override
  State<ProjectTodoPage> createState() => _ProjectTodoPageState();
}

class _ProjectTodoPageState extends State<ProjectTodoPage> {

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
  late List CheckListTask;

  //Save New CheckTask
  SaveNewCheckTask() {
    setState(() {
      db.projectslist[widget.Index]['check_tasks'].add({
        'name': Name.text.trim(),
        'starttime': StartTime.text.trim(),
        'checked': false,
        'date': DateTask.text.trim(),
        'inprogress': false,
      });
      db.ProjectUpdate();
    });
    FillTheLists();
    SetSizeOfLists();
    widget.WhenAddCheckTasks();
    Navigator.of(context).pop();
  }

  //Reorder List 
  ReorderListIteam(int oldIndex, int newIndex) {
    //to solve the problem
    if(oldIndex < newIndex){
      newIndex--;
    }

    //Get the old index
    final tile = db.projectslist[widget.Index]['check_tasks'].removeAt(oldIndex);

    //Place it in the new index
    setState(() {
      db.projectslist[widget.Index]['check_tasks'].insert(newIndex, tile);
    });

    //Save it in the database
    db.ProjectUpdate();
  }

  //Delete CheckTask
  DeleteCheckTask(int index) {
    setState(() {
      db.projectslist[widget.Index]['check_tasks'].removeAt(index);
    });
    db.ProjectUpdate();
    FillTheLists();
    SetSizeOfLists();
  }

  //Make the lists responseve
  FillTheLists() {
    setState(() {
      NotYetTask.clear();
      inProgressTask.clear();
      TaskDone.clear();
    });
    for(var i = 0; i<db.projectslist[widget.Index]['check_tasks'].length; i++){
      if(db.projectslist[widget.Index]['check_tasks'][i]['checked'] == false && db.projectslist[widget.Index]['check_tasks'][i]['inprogress'] == false && db.projectslist[widget.Index]['check_tasks'][i]['checked'] == false){
        setState(() {
          NotYetTask.add(i);
        });
      }else if(db.projectslist[widget.Index]['check_tasks'][i]['inprogress'] == true && db.projectslist[widget.Index]['check_tasks'][i]['checked'] == false){
        setState(() {
          inProgressTask.add(i);
        });
      }else if(db.projectslist[widget.Index]['check_tasks'][i]['checked'] == true){
        setState(() {
          TaskDone.add(i);
        });
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
    setState(() {
      size3 = TaskDone.length * 70;
    });
  }

  @override
  void initState() {
    if(db.bx.get("projects") == null){
      db.ProjectInit();
    }else{
      db.ProjectsLoad();
    }
    if(db.bx.get("background") == null){
      db.BackInitData();
    }else{
      db.BackLoadData();
    }


    //init player music
    player = AudioPlayer()..setAsset('asset/sounddone.wav');
    CheckListTask = db.projectslist[widget.Index]['check_tasks'];

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

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: context.watch<BackProvider>().background == 'empty' ? db.background == '' ? const AssetImage('icons/background/background2.jpg') :  AssetImage(db.background,) : AssetImage(context.watch<BackProvider>().background),fit: BoxFit.cover)
        ),
        child: Scaffold(
        backgroundColor: context.watch<BackProvider>().background == 'empty' ? db.background == '' ? backgroundcolor : db.background == 'icons/background/background4.jpg' || db.background == 'icons/background/background5.jpg' || db.background == 'icons/background/background2.jpg' ? backgroundcolor.withOpacity(0.7) :  db.background == 'icons/background/background8.jpg' ? backgroundcolor.withOpacity(0.6) : db.background == '' ? backgroundcolor : backgroundcolor.withOpacity(0.5) : context.watch<BackProvider>().background == 'icons/background/background4.jpg' || context.watch<BackProvider>().background == 'icons/background/background5.jpg' || context.watch<BackProvider>().background == 'icons/background/background2.jpg' || context.watch<BackProvider>().background == 'icons/background/background8.jpg' ? context.watch<BackProvider>().background == 'icons/background/background8.jpg' ? backgroundcolor.withOpacity(0.6) : context.watch<BackProvider>().background == 'empty' ? backgroundcolor : backgroundcolor.withOpacity(0.7) : backgroundcolor.withOpacity(0.5),
        appBar: AppBar(
          title: GestureDetector(
            onTap: () async {
            },
            child: Text('Manage Your Project',style: TextStyle(color: h1,fontFamily: 'h1',fontSize: 20),textAlign: TextAlign.center,)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              //Tasks todo
              NotYetTask.length != 0 || inProgressTask.length != 0 || TaskDone.length != 0? Padding(
                padding: EdgeInsets.only(top: h*0.01),
                child: Column(
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
                        child: GestureDetector(
                          onTap: () {
                            print(db.projectslist[widget.Index]['check_tasks']);
                          },
                          child: Text('ToDo',style: TextStyle(color: h1,fontSize: h*0.025,fontWeight: FontWeight.w400,fontFamily: 'h2',letterSpacing: 2))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: h*0.01,bottom: h*0.005,right: h*0.025,left: h*0.025),
                      child: SizedBox(
                          height: size1,
                          child: ReorderableListView.builder(
                            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                            shrinkWrap: true,
                            itemCount: db.projectslist[widget.Index]['check_tasks'].length,
                            itemBuilder: ((context, index) {
                              final checktask = db.projectslist[widget.Index]['check_tasks'][index];
                              Future.delayed(Duration.zero, (() {
                                if(checktask['starttime'] == TimeOfDay(hour: timenow.hour, minute: timenow.minute).format(context)){
                                  setState(() {
                                    checktask['inprogress'] = true;
                                  });
                                  FillTheLists();
                                  SetSizeOfLists();
                                }
                              }));
                              return checktask['inprogress'] == false && checktask['checked'] == false ? Dismissible(
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
                                    widget.WhenDeleteCheckTasks();
                                  }else if(direction == DismissDirection.endToStart){
                                    setState(() {
                                      checktask['inprogress'] = true;
                                    });
                                    db.ProjectUpdate();
                                    widget.WhenInProgressCheckTasks();
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
                                                      widget.WhenDoneCheckTasks();
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
                              ) :Container(key: ValueKey(index));
                            }), onReorder: (int oldIndex, int newIndex) { ReorderListIteam(oldIndex, newIndex); },
                          ),
                      ),
                    ) 
                  ],
                ),
              ) : Padding(
                padding: EdgeInsets.only(top: h * 0.1),
                child: OwnFadeTransition(
                    curve: Curves.elasticOut,
                    delayStart: Duration(milliseconds: 50),
                    animationDuration: Duration(milliseconds: 4500),
                    offset: 2,
                    child: Opacity(
                      opacity: 0.5,
                      child: Lottie.asset('icons/99955-empty-notifications.json',height: h * 0.3,width: h* 0.3)),
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
                          itemCount: db.projectslist[widget.Index]['check_tasks'].length,
                          itemBuilder: ((context, index) {
                            final checktask = db.projectslist[widget.Index]['check_tasks'][index];
                            return checktask['inprogress'] == true && checktask['checked'] == false ? Dismissible(
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
                                  widget.WhenDeleteCheckTasks();
                                  widget.WhenNotYetinProgressCheckTask();
                                }else if(direction == DismissDirection.endToStart){
                                  setState(() {
                                    checktask['inprogress'] = false;
                                  });
                                  db.CheckTodoUpdate();
                                  widget.WhenNotYetinProgressCheckTask();
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
                                                    widget.WhenDoneCheckTasks();
                                                    widget.WhenNotYetinProgressCheckTask();
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
                            ) :Container(key: ValueKey(index));
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
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: db.projectslist[widget.Index]['check_tasks'].length,
                          itemBuilder: ((context, index) {
                            final checktask = db.projectslist[widget.Index]['check_tasks'][index];
                            return checktask['checked'] == true ? Dismissible(
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
                                  widget.WhenDeleteCheckTasks();
                                  widget.WhenUnderDoneCheckTask();
                                }else if(direction == DismissDirection.endToStart){
                                  setState(() {
                                    checktask['inprogress'] = true;
                                    checktask['checked'] = false;
                                  });
                                  db.CheckTodoUpdate();
                                  widget.WhenInProgressCheckTasks();
                                  widget.WhenUnderDoneCheckTask();
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
                                                    widget.WhenUnderDoneCheckTask();
                                                    if(checktask['inprogress'] == true){
                                                      widget.WhenInProgressCheckTasks();
                                                    }else{
                                                      widget.WhenNotYetinProgressCheckTask();
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
                            ) : Container(key: ValueKey(index));
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
                    child: AddTodoTask(Name: Name, StartTime: StartTime, onSaveNewCheckTask: () { SaveNewCheckTask(); }, DateTask: DateTask, WhenInProgressCheckTasks: () { widget.WhenInProgressCheckTasks(); },),
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

