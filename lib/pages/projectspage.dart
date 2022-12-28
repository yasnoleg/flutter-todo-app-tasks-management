import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:todo/data_base/databasehive.dart';
import 'package:todo/pages/drawerpage.dart';
import 'package:todo/pages/mainpage.dart';
import 'package:todo/projects_models/CheckTasks.dart';
import 'package:todo/projects_models/add_project.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {

  //DataBase
  DataBase db = DataBase();

  //Date & Time
  DateTime nowdate = DateTime.now();
  TimeOfDay nowtime = TimeOfDay.now();

  //TextEditingControllers
  TextEditingController Name =TextEditingController();
  TextEditingController Note =TextEditingController();
  TextEditingController Lvl =TextEditingController();
  TextEditingController Date =TextEditingController();
  TextEditingController ColorSelect =TextEditingController();
  TextEditingController IndexColor =TextEditingController();
  TextEditingController IconSelect =TextEditingController();

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

  //Save New Project
  SaveNewProject() {
    setState(() {
      db.projectslist.add({
        'name': Name.text.trim(),
        'note': Note.text.trim(),
        'icon': IconSelect.text.trim(),
        'nbr_tasks': 0,
        'nbr_tasks_inprogress': 0,
        'nbr_tasks_done': 0,
        'date': Date.text.trim(),
        'lvl': Lvl.text.trim(),
        'color': ColorSelect.text.trim(),
        'index_color': IndexColor.text.trim(),
        'check_tasks': [],
      });
    });
    db.ProjectUpdate();
    Navigator.of(context).pop();
  }

  //Delete Project
  DelectProject(int index) {
    setState(() {
      db.projectslist.removeAt(index);
    });
    db.ProjectUpdate();
  }


  //Add Check Task 
  WhenAddCheckTasks(int index) {
    setState(() {
      db.projectslist[index]['nbr_tasks'] = db.projectslist[index]['nbr_tasks'] + 1;
    });
  }

  //When Delete Check Task
  WhenDeleteCheckTask(int index) {
    setState(() {
      db.projectslist[index]['nbr_tasks'] = db.projectslist[index]['nbr_tasks'] - 1;
    });
  }

  //Add Check Task 
  WhenDoneCheckTasks(int index) {
    setState(() {
      db.projectslist[index]['nbr_tasks_done'] = db.projectslist[index]['nbr_tasks_done'] + 1;
    });
  }

  //When Delete Check Task
  WhenUnderDoneCheckTask(int index) {
    setState(() {
      db.projectslist[index]['nbr_tasks_done'] = db.projectslist[index]['nbr_tasks_done'] - 1;
    });
  }

  //when Check Task in Progress 
  WhenInProgressCheckTasks(int index) {
    setState(() {
      db.projectslist[index]['nbr_tasks_inprogress'] = db.projectslist[index]['nbr_tasks_inprogress'] + 1;
    });
  }

  //When Delete Check Task
  WhenNotYetinProgressCheckTask(int index) {
    setState(() {
      db.projectslist[index]['nbr_tasks_inprogress'] = db.projectslist[index]['nbr_tasks_inprogress'] - 1;
    });
  }


  @override
  void initState() {
    //db.bx.clear();
    if(db.bx.get("projects") == null){
      db.ProjectInit();
    }else{
      db.ProjectsLoad();
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //Sizes
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: GestureDetector(onTap: () {
                print(db.projectslist);
              },child: Text('Projects',style: TextStyle(color: h1,fontFamily: 'h1',fontSize: 20),textAlign: TextAlign.center,))),
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5,color: h1),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: GestureDetector(
                  onTap: () {
                    Name.clear();
                    Note.clear();
                    Lvl.clear();
                    Date.clear();
                    ColorSelect.clear();
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
                          child: AddProjectPage(Name: Name, Note: Note, Lvl: Lvl, onSaveNewProject: SaveNewProject, DateTask: Date, ColorSelect: ColorSelect, IndexColor: IndexColor, IconSelect: IconSelect,),
                        );
                      })
                    );
                  },
                  child: Icon(Icons.add,size: 20,)),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: Drawer(child: DrawerPage()),
      body: Padding(
        padding: EdgeInsets.only(left: h*0.02,right: h*0.02,top: h*0.015),
        child: db.projectslist.isEmpty == false ? GridView.builder(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.97,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ), 
          itemCount: db.projectslist.length,
          itemBuilder: ((context, index) {
            final project = db.projectslist[index];
            final percent = (project['nbr_tasks_done']*100)/project['nbr_tasks'];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProjectTodoPage(
                    Index: index, 
                    WhenAddCheckTasks: () { WhenAddCheckTasks(index); }, 
                    WhenDeleteCheckTasks: () { WhenDeleteCheckTask(index); }, 
                    WhenDoneCheckTasks: () { WhenDoneCheckTasks(index); },
                    WhenUnderDoneCheckTask: () { WhenUnderDoneCheckTask(index); }, 
                    WhenInProgressCheckTasks: () { WhenInProgressCheckTasks(index); }, 
                    WhenNotYetinProgressCheckTask: () { WhenNotYetinProgressCheckTask(index); },),
                  ),
                );
              },
              child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: HexColor(project['color']),
                    borderRadius: BorderRadius.circular(h*0.02),
                    boxShadow: [
                      BoxShadow(
                        color: h1.withOpacity(0.03),
                        blurRadius: 6,
                        spreadRadius: 5,
                      ),
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: h*0.01,left: h*0.01),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(project['icon'],height: h*0.04,width: h*0.04,color: h1,),
                                  ],
                                ),
                              ),
                              IconButton(color: h1,icon: Icon(Icons.more_horiz_outlined), onPressed: () { showModalBottomSheet(
                                context: context, 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  )
                                ),
                                builder: ((context) {
                                  return Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    height: h*0.1,

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 10,bottom: 15),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
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
                                                        child: HomeMainPage(),
                                                      );
                                                    })
                                                  );
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: h*0.05,
                                                  width: h*0.09,
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
                                                  showDialog(
                                                    context: context, 
                                                    builder: ((context) {
                                                      return AlertDialog(
                                                        title: new Text("Do you want to delete the project !",style: TextStyle(fontFamily: 'h3',fontWeight: FontWeight.w400),),
                                                        actions: <Widget>[
                                                          // usually buttons at the bottom of the dialog
                                                          TextButton(
                                                            child: new Text("Close",style: TextStyle(color: buttoncolor),),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                          ),
                                                          new TextButton(
                                                            child: new Text("Delete",style: TextStyle(color: tasksredcolor),),
                                                            style: ButtonStyle(
                                                              textStyle: MaterialStateProperty.resolveWith((states) {
                                                                TextStyle(color: tasksredcolor);
                                                              }),
                                                            ),
                                                            onPressed: () {
                                                              DelectProject(index);
                                                              Navigator.of(context).pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                  );
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: h*0.05,
                                                  width: h*0.09,
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
                                  );
                                })
                              ); },iconSize: h*0.025,),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: h*0.005,left: h*0.01,right: h*0.01),
                          child: Text('${project['name']}',style: TextStyle(fontSize: h*0.022,fontFamily: 'h2',fontWeight: FontWeight.bold,color: h1),maxLines: 2,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: h*0.005,left: h*0.01,right: h*0.01),
                          child: Text('- ${project['note']}',style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: h*0.018,fontFamily: 'per',fontWeight: FontWeight.w400),maxLines: 3,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: h*0.01,bottom: h*0.01,left: h*0.01,right: h*0.01),
                          child: Row(
                            children: [
                              Expanded(child: Text('- ${project['nbr_tasks']} Tasks',style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: h*0.015,fontFamily: 'per',fontWeight: FontWeight.w400),)),
                              Text('- ${project['nbr_tasks_inprogress']} in Progress',style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: h*0.015,fontFamily: 'per',fontWeight: FontWeight.w400),)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: h*0.01),
                            child: Row(
                              children: [
                                Expanded(
                                  child: LinearPercentIndicator (
                                    lineHeight: h*0.008,
                                    width: 140,
                                    animation: true,
                                    animationDuration: 1500,
                                    percent: project['nbr_tasks'] == 0 ? 0 :(percent/100),
                                    progressColor: h1,
                                    backgroundColor: backgroundcolor.withOpacity(0.5),
                                    barRadius: const Radius.circular(16),
                                  ),
                                ),
                                Text(project['nbr_tasks'] == 0 ? '0 %' : '${project['nbr_tasks_done']} %',style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: h*0.015,fontFamily: 'per',fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(h*0.01),
                          child: Row(
                            children: [
                              Expanded(
                                child: 
                                  Text('${project['date']}',style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: h*0.017,fontFamily: 'per',fontWeight: FontWeight.w500),),
                              ),
                              Container(
                                padding: EdgeInsets.all(2),
                                child: Text('${project['lvl']}',style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: h*0.013,fontFamily: 'per',fontWeight: FontWeight.w500),),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.2),
                                  color: project['lvl'] == 'Hight' ? Color.fromARGB(197, 244, 54, 127) : project['lvl'] == 'Medium' ? Color.fromARGB(255, 54, 200, 244) : Color.fromARGB(255, 8, 209, 125),
                                ),
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            );
          }),
        ) : OwnFadeTransition(
          curve: Curves.elasticOut,
          delayStart: Duration(milliseconds: 50),
          animationDuration: Duration(milliseconds: 4500),
          offset: 2,
          child: Opacity(
            opacity: 0.4,
            child: Lottie.asset('icons/23803-projectmanagement.json')),
        ),
      ),
    );
  }
}