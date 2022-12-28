import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:todo/data_base/databasehive.dart';
import 'package:todo/projects_models/add_icon.dart';

class AddProjectPage extends StatefulWidget {
  TextEditingController Name;
  TextEditingController Note;
  TextEditingController Lvl;
  TextEditingController DateTask;
  TextEditingController IndexColor;
  TextEditingController IconSelect;
  VoidCallback onSaveNewProject;
  TextEditingController ColorSelect;
  AddProjectPage({super.key,
    required this.Name,
    required this.Note,
    required this.Lvl,
    required this.onSaveNewProject,
    required this.DateTask,
    required this.ColorSelect,
    required this.IndexColor,
    required this.IconSelect,
  });

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {

  //DataBase
  DataBase db = DataBase();

  //Key
  final GlobalKey<FormState> _fromkey = GlobalKey<FormState>();

  //Vars
  String lvl = 'Hight';
  int indexcolor = 0;
  String icon ='';

  //Date & Time 
  TimeOfDay start_time = TimeOfDay.now();
  DateTime date_task = DateTime.now();

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
  HexColor taskspinkcolor = HexColor('#FFB9B9');
  HexColor tasksdarkcolor = HexColor('#404258');
  HexColor tasksbluecolor = HexColor('#81C6E8');

  //Lists
  List<String> lvls = [
    'Hight',
    'Medium',
    'low'
  ];

  @override
  void initState() {
    widget.IconSelect.text = 'icons/project_icon/web-programming.png';
    widget.DateTask.text = DateFormat('yyyy/MM/dd').format(date_task);
    widget.ColorSelect.text = '#FF7285';
    widget.IndexColor.text = '0';
    widget.Lvl.text = 'Hight';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //sizes
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    //List of Colors
    List<Widget> circularofcolors = [
      //lightred
      GestureDetector(
        onTap: () {
          setState(() {
            widget.ColorSelect.text = '#FF7285';
            widget.IndexColor.text = '0';
            indexcolor = 0;
          });
        },
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: tasksredcolor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: indexcolor == 0 ? Icon(Icons.done,color: h1,) : Container(),
        ),
      ),
      //light yel
      GestureDetector(
        onTap: () {
          setState(() {
            widget.ColorSelect.text = '#FFCA83';
            widget.IndexColor.text = '1';
            indexcolor = 1;
          });
        },
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: tasksyelcolor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: indexcolor == 1 ? Icon(Icons.done,color: h1,) : Container(),
        ),
      ),
      //light gre
      GestureDetector(
        onTap: () {
          setState(() {
            widget.ColorSelect.text = '#4AD991';
            widget.IndexColor.text = '2';
            indexcolor = 2;
          });
        },
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: tasksgrecolor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: indexcolor == 2 ? Icon(Icons.done,color: h1,) : Container(),
        ),
      ),
      //light pink
      GestureDetector(
        onTap: () {
          setState(() {
            widget.ColorSelect.text = '#FFB9B9';
            widget.IndexColor.text = '3';
            indexcolor = 3;
          });
        },
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: taskspinkcolor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: indexcolor == 3 ? Icon(Icons.done,color: h1,) : Container(),
        ),
      ),
      //dark color
      GestureDetector(
        onTap: () {
          setState(() {
            widget.ColorSelect.text = '#404258';
            widget.IndexColor.text = '4';
            indexcolor = 4;
          });
        },
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: tasksdarkcolor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: indexcolor == 4 ? Icon(Icons.done,color: h1,) : Container(),
        ),
      ),
      //light blue
      GestureDetector(
        onTap: () {
          setState(() {
            widget.ColorSelect.text = '#81C6E8';
            widget.IndexColor.text = '5';
            indexcolor = 5;
          });
        },
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: tasksbluecolor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: indexcolor == 5 ? Icon(Icons.done,color: h1,) : Container(),
        ),
      ),
    ];
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Padding(
        padding: EdgeInsets.only(left: h * 0.015,right: h * 0.015),
        child: Form(
          key: _fromkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Name
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 20,right: 15,bottom: 0),
                        child: Text('Icon',style: TextStyle(color: h1,fontFamily: 'h1',fontWeight: FontWeight.w600,fontSize: 20),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 10,right: 15,bottom: 15),
                        child: GestureDetector(
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
                                        height: 225,
                                        decoration: BoxDecoration(
                                          
                                        ),
                                        child: SizedBox(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 10,top: 10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.IconSelect.text = 'icons/project_icon/web-programming.png'; 
                                                          icon = 'icons/project_icon/web-programming.png';
                                                          Navigator.of(context).pop();
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: iconcolor,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.asset('icons/project_icon/web-programming.png',color: tasksredcolor,height: 40,width: 40,),
                                                          ],
                                                        ),                                          
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.IconSelect.text = 'icons/project_icon/briefing.png'; 
                                                          icon = 'icons/project_icon/briefing.png';
                                                          Navigator.of(context).pop();
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: iconcolor,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.asset('icons/project_icon/briefing.png',color: tasksredcolor,height: 40,width: 40,),
                                                          ],
                                                        ),                                          
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.IconSelect.text = 'icons/project_icon/curve.png'; 
                                                          icon = 'icons/project_icon/curve.png';
                                                          Navigator.of(context).pop();
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: iconcolor,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.asset('icons/project_icon/curve.png',color: tasksredcolor,height: 40,width: 40,),
                                                          ],
                                                        ),                                          
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.IconSelect.text = 'icons/project_icon/design.png'; 
                                                          icon = 'icons/project_icon/design.png';
                                                          Navigator.of(context).pop();
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: iconcolor,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.asset('icons/project_icon/design.png',color: tasksredcolor,height: 40,width: 40,),
                                                          ],
                                                        ),                                          
                                                      ),
                                                    ),
                                                    
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.IconSelect.text = 'icons/project_icon/fast.png'; 
                                                          icon = 'icons/project_icon/fast.png';
                                                          Navigator.of(context).pop();
                                                        });
                                                      },
                                                    child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: iconcolor,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.asset('icons/project_icon/fast.png',color: tasksredcolor,height: 40,width: 40,),
                                                          ],
                                                        ),                                          
                                                      ),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.IconSelect.text = 'icons/project_icon/link.png'; 
                                                          icon = 'icons/project_icon/link.png';
                                                          Navigator.of(context).pop();
                                                        });
                                                      },
                                                    child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: iconcolor,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.asset('icons/project_icon/link.png',color: tasksredcolor,height: 40,width: 40,),
                                                          ],
                                                        ),                                          
                                                      ),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.IconSelect.text = 'icons/project_icon/power.png'; 
                                                          icon = 'icons/project_icon/power.png';
                                                          Navigator.of(context).pop();
                                                        });
                                                      },
                                                    child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: iconcolor,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.asset('icons/project_icon/power.png',color: tasksredcolor,height: 40,width: 40,),
                                                          ],
                                                        ),                                          
                                                      ),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.IconSelect.text = 'icons/project_icon/sketch.png'; 
                                                          icon = 'icons/project_icon/sketch.png';
                                                          Navigator.of(context).pop();
                                                        });
                                                      },
                                                    child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: iconcolor,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.asset('icons/project_icon/sketch.png',color: tasksredcolor,height: 40,width: 40,),
                                                          ],
                                                        ),                                          
                                                      ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 0,top: 10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            widget.IconSelect.text = 'icons/project_icon/united.png'; 
                                                            icon = 'icons/project_icon/united.png';
                                                            Navigator.of(context).pop();
                                                          });
                                                        },
                                                      child: Container(
                                                          height: 60,
                                                          width: 60,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: iconcolor,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Image.asset('icons/project_icon/united.png',color: tasksredcolor,height: 40,width: 40,),
                                                            ],
                                                          ),                                          
                                                        ),
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            widget.IconSelect.text = 'icons/project_icon/working.png'; 
                                                            icon = 'icons/project_icon/working.png';
                                                            Navigator.of(context).pop();
                                                          });
                                                        },
                                                      child: Container(
                                                          height: 60,
                                                          width: 60,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: iconcolor,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Image.asset('icons/project_icon/working.png',color: tasksredcolor,height: 40,width: 40,),
                                                            ],
                                                          ),                                          
                                                        ),
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            widget.IconSelect.text = 'icons/project_icon/case-study.png'; 
                                                            icon = 'icons/project_icon/case-study.png';
                                                            Navigator.of(context).pop();
                                                          });
                                                        },
                                                      child: Container(
                                                          height: 60,
                                                          width: 60,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: iconcolor,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Image.asset('icons/project_icon/case-study.png',color: tasksredcolor,height: 40,width: 40,),
                                                            ],
                                                          ),                                          
                                                        ),
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            widget.IconSelect.text = 'icons/project_icon/statistics.png'; 
                                                            icon = 'icons/project_icon/statistics.png';
                                                            Navigator.of(context).pop();
                                                          });
                                                        },
                                                      child: Container(
                                                          height: 60,
                                                          width: 60,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: iconcolor,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Image.asset('icons/project_icon/statistics.png',color: tasksredcolor,height: 40,width: 40,),
                                                            ],
                                                          ),                                          
                                                        ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                            );
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 184, 182, 182),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(widget.IconSelect.text.trim(),color: tasksredcolor,height: 35,width: 35,),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5,top: 20,right: 15,bottom: 0),
                          child: Text('Name',style: TextStyle(color: h1,fontFamily: 'h1',fontWeight: FontWeight.w600,fontSize: 20),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5,top: 10,right: 15,bottom: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                    return 'Please enter text';
                                  }
                                return null;
                              },
                              controller: widget.Name,
                              decoration: const InputDecoration(
                                hintText: 'Add Project Name..',
                                fillColor: Color.fromARGB(92, 158, 158, 158),
                                filled: true,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //Note
              Padding(
                padding: EdgeInsets.only(left:  h * 0.015,top:  h * 0.015,right:  h * 0.015),
                child: Text('Note',style: TextStyle(color: h1,fontFamily: 'h2',fontSize: h * 0.025,fontWeight: FontWeight.w400),),
              ),
              Padding(
                padding: EdgeInsets.only(left:  h * 0.015,right:  h * 0.015,bottom:  h * 0.015),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                          return 'Please enter some notes';
                        }
                      return null;
                    },
                    controller: widget.Note,
                    minLines: 1,
                    maxLines: 2,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: 'Add Note..',
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
                            widget.DateTask.text = DateFormat('yyyy/MM/dd').format(date_task);
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

              Padding(
                padding: const EdgeInsets.only(left: 15,top: 20,right: 15,bottom: 0),
                child: Text('Lvl',style: TextStyle(color: h1,fontFamily: 'h1',fontWeight: FontWeight.w600,fontSize: 20),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,top: 10,right: 15,bottom: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(92, 158, 158, 158),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: DropdownButton(
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            elevation: 4,
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(10),
                            focusColor: per,
                            hint: Text(lvl),
                            underline: Container(),
                            style: TextStyle(color: per,fontFamily: 'per',fontSize: 15,fontWeight: FontWeight.w500),
                            items: lvls.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              );
                            }).toList(),
                            onChanged: ((String? newValue) {
                              setState(() {
                                lvl = newValue!;
                                widget.Lvl.text = newValue;
                              });
                            })
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Colors
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 20,right: 15,bottom: 0),
                    child: Text('Project Color',style: TextStyle(color: h1,fontFamily: 'h1',fontWeight: FontWeight.w600,fontSize: 20),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10,right: 15,bottom: 20),
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: circularofcolors.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10,top: 8,bottom: 8),
                            child: circularofcolors[index],
                          );
                        }),
                      ),
                    ),
                  ),

              //Button
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.02,bottom: MediaQuery.of(context).size.height * 0.025,),
                    child: GestureDetector(
                      onTap: () {
                        if(_fromkey.currentState!.validate()){
                          widget.onSaveNewProject();
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