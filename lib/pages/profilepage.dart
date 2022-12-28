import 'dart:io';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo/data_base/databasehive.dart';

import 'drawerpage.dart';

class DisProfileP extends StatefulWidget {
  const DisProfileP({super.key});

  @override
  State<DisProfileP> createState() => _DisProfilePState();
}

class _DisProfilePState extends State<DisProfileP> {

  //Data Base
  DataBase db = DataBase();

  //Vars
  bool _display = false;
  bool _display2 = false;
  double nbrtasks = 0;
  int Itiration = 0;
  int Itiration2 = 0;
  int Itiration3 = 0;
  int Itiration4 = 0;
  double maxtasks = 0;
  double nbrtaskscompleted = 0;
  double percenttaskscompleted = 0;
  double nbrtaskscompletedmonth = 0;
  double nbrtasksmonth = 0;
  double percenttaskscompletedmonth = 0;

  //Date / Time
  DateTime DateNow = DateTime.now();
  DateTime CurrentDate = DateTime.now();

  //COLORS
  HexColor buttoncolor = HexColor('#8280FF');
  HexColor tasksredcolor = HexColor('#FF7285');
  HexColor tasksyelcolor = HexColor('#FFCA83');
  HexColor tasksgrecolor = HexColor('#4AD991');
  HexColor tasklightpinkcolor = HexColor('#81C6E8');
  HexColor tasklightbluecolor = HexColor('#FFB9B9');
  HexColor iconcolor = HexColor('#B4B4C6');
  HexColor morningcolor = HexColor('#ffe9a6');
  Color backgroundcolor = Colors.black;
  Color backgroundcolor2 = Colors.white;
  Color h1 = Colors.white;
  Color per = Colors.grey;
  Color inactivtasks = Colors.grey.shade400;
  HexColor tabbarcolor = HexColor('#404258');

  //XFile
  XFile? imag_e;

  //Listes
  List<double> NbrTasks = [];
  List<double> NbrTasksCompleted = [];
  List<double> NbrTasksCompletedMonth = [];
  List<double> NbrTasksMonth = [];

  //Number of task 
  NumberofTask() {
    setState(() {
      nbrtasks = 0;
    });
    if(Itiration > 6) {
      return;
    }else{
      for(var i = 0 ; i < db.taskinfos.length ; i=i+1){
        if('${CurrentDate.year.toString()}/${CurrentDate.day.toString()}/${CurrentDate.month.toString()}' == db.taskinfos[i][4]){
          setState(() {
            nbrtasks = nbrtasks + 1;
          });
        }
      }
      setState(() {
        NbrTasks.add(nbrtasks);
        CurrentDate = DateTime(CurrentDate.year,CurrentDate.month,CurrentDate.day + 1);
        Itiration = Itiration + 1;
      });
      NumberofTask();
    }
  }

  //Number of Tasks Completed
  NumberTasksCompleted() {
    setState(() {
      nbrtasks = 0;
    });
    if(Itiration2 > 6) {
      return;
    }else{
      for(var i = 0 ; i < db.taskinfos.length ; i=i+1){
        if('${CurrentDate.year.toString()}/${CurrentDate.day.toString()}/${CurrentDate.month.toString()}' == db.taskinfos[i][4]){
          if(db.taskinfos[i][10] == 1.0){
            setState(() {
              nbrtasks = nbrtasks + 1;
            });
          }
        }
      }
      setState(() {
        NbrTasksCompleted.add(nbrtasks);
        CurrentDate = DateTime(CurrentDate.year,CurrentDate.month,CurrentDate.day + 1);
        Itiration2 = Itiration2 + 1;
      });
      NumberTasksCompleted();
    }
  }

  //Determinate max number of tasks 
  MaxNbrTasks() {
    for(var i = 0; i < 1 ; i=i+1){
      setState(() {
        maxtasks = NbrTasks[i];
      });
      for(var j = 1; j < NbrTasks.length ; i= i +1){
        if(maxtasks < NbrTasks[j]){
          setState(() {
            maxtasks = NbrTasks[j];
          });
        }
      }
    }
  }

  //Calculate the percentage of tasks completed this week
  PercentTasksCompleted() {
    for(var i = 0; i < NbrTasksCompleted.length; i=i+1){
      setState(() {
        nbrtaskscompleted = nbrtaskscompleted + NbrTasksCompleted[i];
      });
    }
    for(var i = 0; i < NbrTasks.length; i=i+1){
      setState(() {
        nbrtasks = nbrtasks + NbrTasks[i];
      });
    }
    setState(() {
      percenttaskscompleted = ((nbrtaskscompleted * 100) / nbrtasks)/100;
    });
  }

  //Calculate Percentage of tasks completed this month
  NumberTasksCompletedMonth() {
    setState(() {
      nbrtasks = 0;
    });
    if(Itiration3 > 30) {
      return;
    }else{
      for(var i = 0 ; i < db.taskinfos.length ; i=i+1){
        if('${CurrentDate.year.toString()}/${CurrentDate.day.toString()}/${CurrentDate.month.toString()}' == db.taskinfos[i][4]){
          if(db.taskinfos[i][10] == 1.0){
            setState(() {
              nbrtasks = nbrtasks + 1;
            });
          }
        }
      }
      setState(() {
        NbrTasksCompletedMonth.add(nbrtasks);
        CurrentDate = DateTime(CurrentDate.year,CurrentDate.month,CurrentDate.day + 1);
        Itiration3 = Itiration3 + 1;
      });
      NumberTasksCompletedMonth();
    }
  }
    
  //Number of task month
  NumberofTaskMonth() {
    setState(() {
      nbrtasks = 0;
    });
    if(Itiration4 > 30) {
      return;
    }else{
      for(var i = 0 ; i < db.taskinfos.length ; i=i+1){
        if('${CurrentDate.year.toString()}/${CurrentDate.day.toString()}/${CurrentDate.month.toString()}' == db.taskinfos[i][4]){
          setState(() {
            nbrtasks = nbrtasks + 1;
          });
        }
      }
      setState(() {
        NbrTasksMonth.add(nbrtasks);
        CurrentDate = DateTime(CurrentDate.year,CurrentDate.month,CurrentDate.day + 1);
        Itiration4 = Itiration4 + 1;
      });
      NumberofTaskMonth();
    }
  }

  //Calculate the percentage of tasks completed this week
  PercentTasksCompletedMonth() {
    for(var i = 0; i < NbrTasksCompletedMonth.length; i=i+1){
      setState(() {
        nbrtaskscompletedmonth = nbrtaskscompletedmonth + NbrTasksCompletedMonth[i];
      });
    }
    for(var i = 0; i < NbrTasksMonth.length; i=i+1){
      setState(() {
        nbrtasksmonth = nbrtasksmonth + NbrTasksMonth[i];
      });
    }
    setState(() {
      percenttaskscompletedmonth = ((nbrtaskscompletedmonth * 100) / nbrtasksmonth)/100;
    });
  }

  //Choose profile picture 
  chooseProfilePic() async {
    final imagefile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );
    setState(() {
      imag_e = imagefile;
      db.imagepath = imagefile!.path.toString();
    });
    db.UploadImagePath();
  }

  
  @override
  void initState() {

    Future.delayed(Duration.zero, () {
      setState(() {
        CurrentDate = DateTime(DateNow.year,DateNow.month,DateNow.day - 6);
      });
      NumberofTaskMonth();
      setState(() {
        CurrentDate = DateTime(DateNow.year,DateNow.month,DateNow.day - 6);
      });
      NumberTasksCompletedMonth();
      PercentTasksCompletedMonth();
      //================================================
      setState(() {
        CurrentDate = DateTime(DateNow.year,DateNow.month,DateNow.day - 6);
      });
      NumberofTask();
      setState(() {
        CurrentDate = DateTime(DateNow.year,DateNow.month,DateNow.day - 6);
      });
      NumberTasksCompleted();
      PercentTasksCompleted();
    });

    //db.taskinfos.clear();
    //db.bx.clear();
    if(db.bx.get("todo") == null) {
      db.InitData();
    }else{
      db.LoadData();
    }

    if(db.bx.get("path") == null) {
      db.InitImagePath();
    }else{
     db.LoadImagePath();
    }
    
    if(db.bx.get("background") == null){
      db.BackInitData();
    }else{
      db.BackLoadData();
    }
    
    if(db.bx.get("Check") == null){
      db.CheckTodoInit();
    }else{
      db.CheckTodoLoad();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    //Height + Width
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    //List Gradiant
    LinearGradient _barsGradient = const LinearGradient(
        colors: [
          Colors.lightBlueAccent,
          Colors.greenAccent,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Profile',style: TextStyle(color: h1,fontFamily: 'h1',fontSize: 20),textAlign: TextAlign.center,),
      ),
      drawer: Drawer(child: DrawerPage(),),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Padding(
          padding: EdgeInsets.only(left: h * 0.015,right: h * 0.015),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Profile pic + name + description
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  //Profile picture
                  Padding(
                    padding:  EdgeInsets.only(right: h * 0.02, bottom: h * 0.02),
                    child: GestureDetector(
                      onTap: () {
                        chooseProfilePic();
                      },
                      child: Container(
                        height: h * 0.1,
                        width: w * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: db.imagepath == null ? Image.asset('icons/background/backgrounddrawer.jpg',fit: BoxFit.cover,height: h * 0.1,) : Image.file(File(db.imagepath!),fit: BoxFit.cover,height: h * 0.1,)),
                      ),
                    ),
                  ),
                  //Name + description
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: h * 0.01),
                          child: Text('Your Name',style: TextStyle(color: h1,fontFamily: 'h2',fontSize: h * 0.035,fontWeight: FontWeight.w800)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              //Graphic
              Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 10),
                child: SizedBox(
                  height: h * 0.35,
                  child: ClipRRect(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(h*0.015),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: h * 0.01, right: h * 0.01,top: h * 0.01),
                        child: _display == false ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      GradientIcon(Icons.dashboard,20,_barsGradient),
                                      SizedBox(width: 15,),
                                      Text('New Tasks',style: TextStyle(color: h1,fontFamily: 'h1',fontSize: 20,fontWeight: FontWeight.w300)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _display = true;
                                    });
                                  },
                                  child: Icon(Icons.arrow_forward_ios_outlined,size: 17,)),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: h * 0.04),
                              child: SizedBox(
                                height: h * 0.25,
                                child: BarChart(
                                  BarChartData(
                                    gridData: FlGridData(show: false),
                                    alignment: BarChartAlignment.spaceAround,
                                    maxY: 7,
                                    barTouchData: BarTouchData(
                                      enabled: false,
                                      touchTooltipData: BarTouchTooltipData(
                                        tooltipBgColor: Colors.transparent,
                                        tooltipPadding: EdgeInsets.all(h * 0.02),
                                        tooltipMargin: 8,
                                        getTooltipItem: (
                                          BarChartGroupData group,
                                          int groupIndex,
                                          BarChartRodData rod,
                                          int rodIndex,
                                        ) {
                                          return BarTooltipItem(
                                            rod.toY.round().toString(),
                                            const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 30,
                                          getTitlesWidget: (double value, TitleMeta meta) {
                                            const style = TextStyle(
                                              color: Color(0xff7589a2),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            );
                                            String text;
                                            switch (value.toInt()) {
                                              case 0:
                                                text = '${DateNow.day - 6}';
                                                break;
                                              case 1:
                                                text = '${DateNow.day - 5}';
                                                break;
                                              case 2:
                                                text = '${DateNow.day - 4}';
                                                break;
                                              case 3:
                                                text = '${DateNow.day - 3}';
                                                break;
                                              case 4:
                                                text = '${DateNow.day - 2}';
                                                break;
                                              case 5:
                                                text = '${DateNow.day - 1}';
                                                break;
                                              case 6:
                                                text = '${DateNow.day}';
                                                break;
                                              default:
                                                text = '${DateNow.day}';
                                                break;
                                            }
                                            return SideTitleWidget(
                                              axisSide: meta.axisSide,
                                              space: 4,
                                              child: Text(text, style: style),
                                            );
                                          },
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(showTitles: false),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles: SideTitles(showTitles: false),
                                      ),
                                      rightTitles: AxisTitles(
                                        sideTitles: SideTitles(showTitles: false),
                                      ),
                                    ),
                                    barGroups: [
                                      BarChartGroupData(
                                        x: 0,
                                        barRods: [
                                          BarChartRodData(
                                            borderRadius: BorderRadius.circular(4),
                                            width: h * 0.035,
                                            toY: NbrTasks.isEmpty == true ? 0 : NbrTasks[0],
                                            gradient: _barsGradient,
                                          )
                                        ],
                                        showingTooltipIndicators: [0],
                                      ),
                                      BarChartGroupData(
                                        x: 1,
                                        barRods: [
                                          BarChartRodData(
                                            borderRadius: BorderRadius.circular(4),
                                            width: h * 0.035,
                                            toY: NbrTasks.length < 2 ? 0 : NbrTasks[1],
                                            gradient: _barsGradient,
                                          )
                                        ],
                                        showingTooltipIndicators: [0],
                                      ),
                                      BarChartGroupData(
                                        x: 2,
                                        barRods: [
                                          BarChartRodData(
                                            borderRadius: BorderRadius.circular(4),
                                            width: h * 0.035,
                                            toY: NbrTasks.length < 3 ? 0 : NbrTasks[2],
                                            gradient: _barsGradient,
                                          )
                                        ],
                                        showingTooltipIndicators: [0],
                                      ),
                                      BarChartGroupData(
                                        x: 3,
                                        barRods: [
                                          BarChartRodData(
                                            borderRadius: BorderRadius.circular(4),
                                            width: h * 0.035,
                                            toY: NbrTasks.length < 4 ? 0 : NbrTasks[3],
                                            gradient: _barsGradient,
                                          )
                                        ],
                                        showingTooltipIndicators: [0],
                                      ),
                                      BarChartGroupData(
                                        x: 4,
                                        barRods: [
                                          BarChartRodData(
                                            borderRadius: BorderRadius.circular(4),
                                            width: h * 0.035,
                                            toY: NbrTasks.length < 5 ? 0 : NbrTasks[4],
                                            gradient: _barsGradient,
                                          )
                                        ],
                                        showingTooltipIndicators: [0],
                                      ),
                                      BarChartGroupData(
                                        x: 5,
                                        barRods: [
                                          BarChartRodData(
                                            borderRadius: BorderRadius.circular(4),
                                            width: h * 0.035,
                                            toY: NbrTasks.length < 6 ? 0 : NbrTasks[5],
                                            gradient: _barsGradient,
                                          )
                                        ],
                                        showingTooltipIndicators: [0],
                                      ),
                                      BarChartGroupData(
                                        x: 6,
                                        barRods: [
                                          BarChartRodData(
                                            borderRadius: BorderRadius.circular(4),
                                            width: h * 0.035,
                                            toY: NbrTasks.length < 7 ? 0 : NbrTasks[6],
                                            gradient: _barsGradient,
                                          )
                                        ],
                                        showingTooltipIndicators: [0],
                                      ),
                                    ],
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                  ),
                                  swapAnimationDuration: Duration(milliseconds: 200), // Optional
                                  swapAnimationCurve: Curves.linear, // Optional
                                ),
                              ),
                            ),
                          ],
                        ) : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      GradientIcon(Icons.dashboard,20,_barsGradient),
                                      SizedBox(width: 15,),
                                      Text('Task Completed',style: TextStyle(color: h1,fontFamily: 'h1',fontSize: 20,fontWeight: FontWeight.w300)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _display = false;
                                    });
                                  },
                                  child: Icon(Icons.arrow_forward_ios_outlined,size: 17,)),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: h * 0.04),
                              child: SizedBox(
                                height: h * 0.25,
                                child: BarChart(
                                  BarChartData(
                                    gridData: FlGridData(show: false),
                                    alignment: BarChartAlignment.spaceAround,
                                    maxY: 7,
                                    barTouchData: BarTouchData(
                                      enabled: false,
                                      touchTooltipData: BarTouchTooltipData(
                                        tooltipBgColor: Colors.transparent,
                                        tooltipPadding: EdgeInsets.all(h * 0.02),
                                        tooltipMargin: 8,
                                        getTooltipItem: (
                                          BarChartGroupData group,
                                          int groupIndex,
                                          BarChartRodData rod,
                                          int rodIndex,
                                        ) {
                                          return BarTooltipItem(
                                            rod.toY.round().toString(),
                                            const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 30,
                                          getTitlesWidget: (double value, TitleMeta meta) {
                                            const style = TextStyle(
                                              color: Color(0xff7589a2),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            );
                                            String text;
                                            switch (value.toInt()) {
                                              case 0:
                                                text = '${DateNow.day - 6}';
                                                break;
                                              case 1:
                                                text = '${DateNow.day - 5}';
                                                break;
                                              case 2:
                                                text = '${DateNow.day - 4}';
                                                break;
                                              case 3:
                                                text = '${DateNow.day - 3}';
                                                break;
                                              case 4:
                                                text = '${DateNow.day - 2}';
                                                break;
                                              case 5:
                                                text = '${DateNow.day - 1}';
                                                break;
                                              case 6:
                                                text = '${DateNow.day}';
                                                break;
                                              default:
                                                text = '${DateNow.day}';
                                                break;
                                            }
                                            return SideTitleWidget(
                                              axisSide: meta.axisSide,
                                              space: 4,
                                              child: Text(text, style: style),
                                            );
                                          },
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(showTitles: false),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles: SideTitles(showTitles: false),
                                      ),
                                      rightTitles: AxisTitles(
                                        sideTitles: SideTitles(showTitles: false),
                                      ),
                                    ),
                                    barGroups: [
                                      BarChartGroupData(
                                        x: 0,
                                        barRods: [
                                          BarChartRodData(
                                            borderRadius: BorderRadius.circular(4),
                                            width: h * 0.035,
                                            toY: NbrTasksCompleted.isEmpty == true ? 0 : NbrTasksCompleted[0],
                                            gradient: _barsGradient,
                                          )
                                        ],
                                        showingTooltipIndicators: [0],
                                      ),
                                      BarChartGroupData(
                                        x: 1,
                                        barRods: [
                                          BarChartRodData(
                                            borderRadius: BorderRadius.circular(4),
                                            width: h * 0.035,
                                            toY: NbrTasksCompleted.length < 2 ? 0 : NbrTasksCompleted[1],
                                            gradient: _barsGradient,
                                          )
                                        ],
                                        showingTooltipIndicators: [0],
                                      ),
                                      BarChartGroupData(
                                        x: 2,
                                        barRods: [
                                          BarChartRodData(
                                            borderRadius: BorderRadius.circular(4),
                                            width: h * 0.035,
                                            toY: NbrTasksCompleted.length < 3 ? 0 : NbrTasksCompleted[2],
                                            gradient: _barsGradient,
                                          )
                                        ],
                                        showingTooltipIndicators: [0],
                                      ),
                                      BarChartGroupData(
                                        x: 3,
                                        barRods: [
                                          BarChartRodData(
                                            borderRadius: BorderRadius.circular(4),
                                            width: h * 0.035,
                                            toY: NbrTasksCompleted.length < 4 ? 0 : NbrTasksCompleted[3],
                                            gradient: _barsGradient,
                                          )
                                        ],
                                        showingTooltipIndicators: [0],
                                      ),
                                      BarChartGroupData(
                                        x: 4,
                                        barRods: [
                                          BarChartRodData(
                                            borderRadius: BorderRadius.circular(4),
                                            width: h * 0.035,
                                            toY: NbrTasksCompleted.length < 5 ? 0 : NbrTasksCompleted[4],
                                            gradient: _barsGradient,
                                          )
                                        ],
                                        showingTooltipIndicators: [0],
                                      ),
                                      BarChartGroupData(
                                        x: 5,
                                        barRods: [
                                          BarChartRodData(
                                            borderRadius: BorderRadius.circular(4),
                                            width: h * 0.035,
                                            toY: NbrTasksCompleted.length < 6 ? 0 : NbrTasksCompleted[5],
                                            gradient: _barsGradient,
                                          )
                                        ],
                                        showingTooltipIndicators: [0],
                                      ),
                                      BarChartGroupData(
                                        x: 6,
                                        barRods: [
                                          BarChartRodData(
                                            borderRadius: BorderRadius.circular(4),
                                            width: h * 0.035,
                                            toY: NbrTasksCompleted.length < 7 ? 0 : NbrTasksCompleted[6],
                                            gradient: _barsGradient,
                                          )
                                        ],
                                        showingTooltipIndicators: [0],
                                      ),
                                    ],
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                  ),
                                  swapAnimationDuration: Duration(milliseconds: 200), // Optional
                                  swapAnimationCurve: Curves.linear, // Optional
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //Data
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: SizedBox(
                  height: h * 0.27,
                  child: ClipRRect(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(h*0.015),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: h * 0.01, right: h * 0.01,top: h * 0.01),
                        child:Column(    
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 7,top: 0,right: 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            GradiantWidget(Image.asset('icons/data-science.png',color: h1,), 20, _barsGradient)
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text('Data',style: TextStyle(color: h1,fontFamily: 'h1',fontSize: 20,fontWeight: FontWeight.w300)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: h * 0.04),
                              child: Table(
                                children: [
                                  TableRow(
                                    children: [
                                      SizedBox(width: h * 0.02,),
                                      Text('New Tasks',style: TextStyle(color: per,fontFamily: 'per',fontSize: 14,fontWeight: FontWeight.w400),),
                                      Text('Tasks Completed',style: TextStyle(color: per,fontFamily: 'per',fontSize: 14,fontWeight: FontWeight.w400),),
                                      Text('You Have Complete',style: TextStyle(color: per,fontFamily: 'per',fontSize: 14,fontWeight: FontWeight.w400),),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      SizedBox(height: h * 0.02,width: 10,),
                                      SizedBox(height: h * 0.02,width: 10,),
                                      SizedBox(height: h * 0.02,width: 10,),
                                      SizedBox(height: h * 0.02,width: 10,),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text('This Day',style: TextStyle(color: per,fontFamily: 'per',fontSize: 14,fontWeight: FontWeight.w400),),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('${NbrTasks.isEmpty == true ? 0 : NbrTasks[6]}',style: TextStyle(color: h1,fontFamily: 'per',fontSize: 14,fontWeight: FontWeight.w400),),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('${NbrTasksCompleted.isEmpty == true ? 0 : NbrTasksCompleted[6]}',style: TextStyle(color: h1,fontFamily: 'per',fontSize: 14,fontWeight: FontWeight.w400),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('${NbrTasks.isEmpty == true ? 0 : ((NbrTasksCompleted[6]*100)/NbrTasks[6]).isNaN ? 0 : ((NbrTasksCompleted[6]*100)/NbrTasks[6]).toStringAsFixed(1)} %   ',style: TextStyle(color: NbrTasksCompleted.isEmpty == true ? Colors.red : ((NbrTasksCompleted[6]*100)/NbrTasks[6]).isNaN ? Colors.red : ((NbrTasksCompleted[6]*100)/NbrTasks[6]) < 50.0 ? Colors.red : Colors.green, fontFamily: 'per',fontSize: 14,fontWeight: FontWeight.w400),),
                                          Icon( NbrTasksCompleted.isEmpty == true ? Icons.arrow_circle_down_outlined : ((NbrTasksCompleted[3]*100)/NbrTasks[3]).isNaN ? Icons.arrow_circle_down_outlined : ((NbrTasksCompleted[3]*100)/NbrTasks[3]) < 50.0 ? Icons.arrow_circle_down_outlined : Icons.arrow_circle_up_outlined,size: 15,color: NbrTasksCompleted.isEmpty == true ? Colors.red : ((NbrTasksCompleted[3]*100)/NbrTasks[3]).isNaN ? Colors.red : ((NbrTasksCompleted[3]*100)/NbrTasks[3]) < 50.0 ? Colors.red : Colors.green,),
                                        ],
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      SizedBox(height: h * 0.02,width: 10,),
                                      SizedBox(height: h * 0.02,width: 10,),
                                      SizedBox(height: h * 0.02,width: 10,),
                                      SizedBox(height: h * 0.02,width: 10,),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text('This Week',style: TextStyle(color: per,fontFamily: 'per',fontSize: 14,fontWeight: FontWeight.w400),),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('${nbrtasks}',style: TextStyle(color: h1,fontFamily: 'per',fontSize: 14,fontWeight: FontWeight.w400),),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('${nbrtaskscompleted}',style: TextStyle(color: h1,fontFamily: 'per',fontSize: 14,fontWeight: FontWeight.w400),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('${(percenttaskscompleted*100).isNaN ? 0 : (percenttaskscompleted*100).toStringAsFixed(1)} %   ',style: TextStyle(color: NbrTasksCompleted.isEmpty == true ? Colors.green :  (percenttaskscompleted*100) < 50.0 ? Colors.red : Colors.green,fontFamily: 'per',fontSize: 14,fontWeight: FontWeight.w400),),
                                          Icon( NbrTasksCompleted.isEmpty == true ? Icons.arrow_circle_down_outlined : (percenttaskscompleted*100).isNaN ? Icons.arrow_circle_down_outlined : (percenttaskscompleted*100) < 50.0 ? Icons.arrow_circle_down_outlined : Icons.arrow_circle_up_outlined,size: 15,color: NbrTasksCompleted.isEmpty == true ? Colors.red : (percenttaskscompleted*100).isNaN ? Colors.red : (percenttaskscompleted*100) < 50.0 ? Colors.red : Colors.green,),
                                        ],
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      SizedBox(height: h * 0.02,width: 10,),
                                      SizedBox(height: h * 0.02,width: 10,),
                                      SizedBox(height: h * 0.02,width: 10,),
                                      SizedBox(height: h * 0.02,width: 10,),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text('This Month',style: TextStyle(color: per,fontFamily: 'per',fontSize: 14,fontWeight: FontWeight.w400),),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('${nbrtasksmonth}',style: TextStyle(color: h1,fontFamily: 'per',fontSize: 14,fontWeight: FontWeight.w400),),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('${nbrtaskscompletedmonth}',style: TextStyle(color: h1,fontFamily: 'per',fontSize: 14,fontWeight: FontWeight.w400),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('${(percenttaskscompletedmonth*100).isNaN ? 0 : (percenttaskscompletedmonth*100).toStringAsFixed(1)} %   ',style: TextStyle(color: NbrTasksCompletedMonth.isEmpty == true ? Colors.green :  (percenttaskscompletedmonth*100) < 50.0 ? Colors.red : Colors.green,fontFamily: 'per',fontSize: 14,fontWeight: FontWeight.w400),),
                                          Icon( NbrTasksCompletedMonth.isEmpty == true ? Icons.arrow_circle_down_outlined : (percenttaskscompletedmonth*100).isNaN ? Icons.arrow_circle_down_outlined : (percenttaskscompletedmonth*100) < 50.0 ? Icons.arrow_circle_down_outlined : Icons.arrow_circle_up_outlined,size: 15,color: NbrTasksCompletedMonth.isEmpty == true ? Colors.red : (percenttaskscompletedmonth*100).isNaN ? Colors.red : (percenttaskscompletedmonth*100) < 50.0 ? Colors.red : Colors.green,),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    )
                  )
                ),
              ),
              
              //Percentage
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: h * 0.36,
                  child: ClipRRect(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(h*0.015),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: h * 0.01, right: h * 0.01,top: h * 0.01),
                        child:Column(    
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                GradiantWidget(Image.asset('icons/discount.png',color: h1,), 30, _barsGradient)
                                              ],
                                            ),
                                            SizedBox(width: 10,),
                                            Text('Percentage',style: TextStyle(color: h1,fontFamily: 'h1',fontSize: 20,fontWeight: FontWeight.w300)),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if(_display2 == false){
                                              _display2 = true;
                                            }else{
                                              _display2 = false;
                                            }
                                          });
                                        },
                                        child: Icon(Icons.arrow_forward_ios_outlined,size: 20,color: h1,)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            _display2 == false ? Padding(
                              padding: EdgeInsets.only(top: h * 0.04),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: h * 0.25,
                                    child: GradiantWidget(
                                      CircularPercentIndicator(
                                          radius: 80,
                                          animation: true,
                                          animationDuration: 1500,
                                          lineWidth: 20,
                                          percent: percenttaskscompleted.isNaN ? 0 : percenttaskscompleted,
                                          progressColor: h1,
                                          backgroundColor: backgroundcolor.withOpacity(0.5),
                                          circularStrokeCap: CircularStrokeCap.round,
                                          center: Text('${percenttaskscompleted.isNaN ? 0 : (percenttaskscompleted*100).toStringAsFixed(1)}%',style: TextStyle(color: h1,fontFamily: 'h2',fontSize: 25,fontWeight: FontWeight.bold)),
                                        ), 
                                      160, 
                                      _barsGradient
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: h * 0.02,
                                        width: h * 0.02,
                                        decoration: BoxDecoration(
                                          gradient: _barsGradient,
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text('Tasks that you have'),
                                          Text('completed 100%'),
                                          Text('this week'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ) : Padding(
                              padding: EdgeInsets.only(top: h * 0.04),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: h * 0.25,
                                    child: GradiantWidget(
                                      CircularPercentIndicator(
                                          radius: 80,
                                          animation: true,
                                          animationDuration: 1500,
                                          lineWidth: 20,
                                          percent: percenttaskscompletedmonth.isNaN ? 0 : percenttaskscompletedmonth,
                                          progressColor: h1,
                                          backgroundColor: backgroundcolor.withOpacity(0.5),
                                          circularStrokeCap: CircularStrokeCap.round,
                                          center: Text('${percenttaskscompletedmonth.isNaN ? 0 : (percenttaskscompletedmonth*100).toStringAsFixed(1)}%',style: TextStyle(color: h1,fontFamily: 'h2',fontSize: 25,fontWeight: FontWeight.bold)),
                                        ), 
                                      160, 
                                      _barsGradient
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: h * 0.02,
                                        width: h * 0.02,
                                        decoration: BoxDecoration(
                                          gradient: _barsGradient,
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text('Tasks that you have'),
                                          Text('completed 100%'),
                                          Text('this month'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    )
                  )
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
class GradiantWidget extends StatelessWidget {
  GradiantWidget(
    this.widget,
    this.size,
    this.gradient,
  );

  final Widget widget;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: widget,
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}